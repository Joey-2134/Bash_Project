#!/bin/bash

echo "Hello World"
id="$1"

if [ -n "$id" ]; then
    while true; do
        read -p "Command: " req args

        if [[ "$req" == "exit" ]]; then
        break
        fi

        response=$(./server.sh "$req" "$id" $args)
    done
fi



    