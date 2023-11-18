#!/bin/bash
#set -x
sender="$1"
receiver="$2"
msg="$3"
receiver_wall_file="$receiver/wall.txt"                 #receivers wall file path

if [ -d "$sender" ] && [ -d "$receiver" ]; then         #checks if sender and receiver exist
    if [ -n "$msg" ]; then                              #checks if the message isnt empty
        echo "$sender : $msg" >> "$receiver_wall_file"  #writes message and senders name to receivers wall
        echo "ok: - message posted!"
    else
        echo "nok: - No message entered"
    fi
else
    echo "nok: - Either Sender or Receiver don't exist"
fi