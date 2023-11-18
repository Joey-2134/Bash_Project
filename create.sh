#!/bin/bash
id="$1"

if [ -n "$id" ]; then       #checks if parameter isn't empty
    if [ -d "$id" ]; then   #checks if entered user id already exists
        echo "nok: user already exists"
    else
        mkdir -p "$id"  #creates user dir

        wall_name="$id/wall.txt"
        touch "$wall_name"      #creates user wall within user dir
        echo "Wall:" >> "$wall_name"

        friends_name="$id/friends.txt" 
        touch "$friends_name"   #creates user friends list within user dir

        echo "ok: User Created!"
    fi
else
    echo "nok: no name entered"
fi