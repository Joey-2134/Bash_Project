#!/bin/bash
#set -x

trapControlC() {        #function which runs when script ends with control+c
    rm -f "$serverPipe"
    exit 0
}

trap trapControlC INT

serverPipe="server.pipe"

if [[ ! -p $serverPipe ]]; then #if a server pipe doesn't exist, creates one
    mkfifo $serverPipe
fi

while true; do #endless loop
    if read line <$serverPipe; then #reads from the server pipe
        IFS=' ' read -ra input <<< "$line" #seperates input read from the pipe into an array
        clientId=${input[1]}    #req, id, args

        case "${input[0]}" in  #switch cases to handle client commands
            "create")
                response=$(./create.sh "${input[1]}")
                ;;
            "add")
                response=$(./add_friend.sh "${input[1]}" "${input[2]}")
                ;;
            "post")
                response=$(./post_messages.sh "${input[1]}" "${input[2]}" "${input[@]:3}")
                ;;
            "display")
                response=$(./display_wall.sh "${input[1]}")
                ;;
            *)
                echo "nok: bad request"
        esac
        echo "$response" > "${clientId}.pipe"
    fi
done
trapControlC