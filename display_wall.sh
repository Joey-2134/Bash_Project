#!/bin/bash

id="$1"

if [ -d "$id" ]; then  #checks if user exists
    cat "$id/wall.txt"  #prints file to console
    echo  
    echo "ok: displaying wall!"
else
    echo "nok: - User does not exist"
fi