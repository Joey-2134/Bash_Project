#!/bin/bash
#set -x
id="$1"

if [ ! -d "./$id" ]; then
    response=$(./create.sh "$id")

    if [[ "$response" == "ok: "* ]]; then
        echo "SUCCESS: user created!"
    elif [[ "$response" == "nok: "* ]]; then
        echo "ERROR: user already exists"
    else
        echo "Unknown response from server"
        exit 1
    fi
fi

while true; do
    read -p "Command: " req args
    if [[ "$req" == "exit" ]]; then
        break
     fi

    response=$(./server.sh "$req" "$id" $args)

    responseHead=$(echo "$response" | head -n -1)
    responseTail=$(echo "$response" | tail -n 1)
    
    if [[ "$responseTail" == "ok: "* ]]; then
        echo "SUCCESS: ${responseTail:4}"
        if [[ "$responseTail" == "ok: displaying wall!" ]]; then
            echo "$responseHead"
        fi

    elif [[ "$responseTail" == "nok: "* ]]; then
        echo "ERROR: ${responseTail:5}"

    else
        echo "Unknown response from server"
    fi
done
