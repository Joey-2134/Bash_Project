#!/bin/bash
echo "Type exit to end"

while true; do
    read -p "Command: " userInput   #reads user input from terminal on every iteration of loop

    input=($userInput) #stores input values in an array (delimited by space by default)

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
        "exit") #exits loop if users chooses to
            break;
            ;;
        *)
            echo "nok - bad request"
    esac
done