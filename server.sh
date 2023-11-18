#!/bin/bash
#set -x
input=("$@") #stores input values in an array

case "${input[0]}" in  #first input is script which user chooses to run, other inputs are arguments to that script
    "create")
        ./create.sh "${input[1]}"
        ;;
    "add")
         ./add_friend.sh "${input[1]}" "${input[2]}"
         ;;
     "post")
        ./post_messages.sh "${input[1]}" "${input[2]}" "${input[@]:3}"
         ;;
    "display")
        ./display_wall.sh "${input[1]}"
         ;;
    *)
        echo "nok: bad request"
esac