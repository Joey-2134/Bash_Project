#!/bin/bash
#set -x
id="$1"
clientPipe="$id.pipe"

trapControlC() {    #function which runs when script ends with control+c
    rm -f "$clientPipe"
    exit 0
}

trap trapControlC INT

if [[ ! -p $clientPipe ]]; then #if pipe doesn't exist for client, creates one
    mkfifo $clientPipe
fi

if [ ! -d "./$id" ]; then   #if the id entered doesn't exist, creates one
    echo "create $id" > server.pipe # Send request to server

    read response < $clientPipe # Read response from server

    if [[ "$response" == "ok: "* ]]; then   #handles response
        echo "SUCCESS: user created!"
    elif [[ "$response" == "nok: "* ]]; then
        echo "ERROR: user already exists"
    else
        echo "Unknown response from server"
    fi
fi

while true; do  #endless loop
    read -p "Command: " req args    #reads entered input into req and args variables
    if [[ "$req" == "exit" ]]; then #if req is exit then leave loop
        break   
     fi

    echo "$req $id $args" > server.pipe # Send request to server

    read response < $clientPipe # Read response from server

    if [[ "$response" == "Wall:"* ]]; then  #case for handling displaying wall since it returns a differently formatted response than other commands
        cat "$id/wall.txt"
    elif [[ "$response" == "ok: "* ]]; then  #prints the response without the "ok: "
        echo "${response:5}"
    elif [[ "$response" == "nok: "* ]]; then
        echo "ERROR: ${responseTail:6}" #prints the response without the "nok: "
    else
        echo "Unknown response from server"
    fi
done

trapControlC