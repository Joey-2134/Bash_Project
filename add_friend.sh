#!/bin/bash

id="$1"
friend="$2"

users_friends_file="$id/friends.txt"        #paths for friends lists
friend_friends_file="$friend/friends.txt"

if [ -d "$id" ] && [ -d "$friend" ]; then   #checks if both users exist
    if grep "$friend" "$users_friends_file" > /dev/null  && grep "$id" "$friend_friends_file" > /dev/null; then #checks that they aren't already friends
        echo "nok - Users are already friends"
    else
        echo "$friend" >> "$users_friends_file" #adds friend to users friends list
        echo "$id" >> "$friend_friends_file"    #adds user to friends friend list
        
        echo "ok: friend added!"
    fi
else 
    echo "nok - One of the inputs do not exist"
fi
