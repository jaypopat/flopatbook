#!/bin/bash

id=$1

if [ "$#" -eq 1 ]; then
    echo "Username given: $id"

    if [ ! -p "../pipes/$id.pipe" ]; then 
        mkfifo ../pipes/$id.pipe
    fi

    if [ ! -p "../pipes/server.pipe" ]; then 
        mkfifo ../pipes/server.pipe
    fi

    cd ../users

    if [ ! -d "$id" ]; then
        echo "ERROR: User not found"
        echo "Would you like to create a new user? --> $id (yes/no) :"
        read -p choice
        
        case "$choice" in
            yes)

                echo "create" > ../pipes/server.pipe

                cd ../server/scripts
                
                ./server.sh $id

                cd ..
             
                ;;
            no)
                echo "Bye!" && exit
                ;;
            *)
                echo "Invalid input. Use (yes/no) next time. Bye!" && exit 
                ;;
        esac
    fi

    echo -e "User $id logged in!\n"

    while true; do 
        # echo "Add Friend: add <user-to-add>"
        # echo "Post on User's Wall: post <receiver> <message>"
        # echo -e "Display Your Wall: display\n"

        cd ../pipes

        if read serverOutput < $id.pipe ; then # If user.pipe is not empty

            read serverOutput < $id.pipe
            echo "$serverOutput";

        fi

        read -p "Enter request with arguments: " request

        echo $request > server.pipe

        cd ../server/scripts

        ./server.sh $id

        cd ..

        # set -- $request
    #     request=$1

    #     case $request in
    #        add)

    #             userToAdd=$2

    #         #    ./add_friend.sh $id $userToAdd
    #             ./server.sh $request $id $userToAdd
    #            ;;
    #        post)

    #             receiver=$2
    #             message=$3

    #             if [ -n "$4" ]; then
    #                 for arg in "${@:4}"; do
    #                     message+=" $arg"
    #                 done
    #             fi

    #         #    ./post_messages.sh $id $receiver $message
    #             ./server.sh $request $id $receiver $message
    #            ;;
    #        display)
                
    #             # ./display_wall.sh $id
    #             ./server.sh $request $id
    #            ;;
    #        *)
    #            echo "Accepted Commands: {create|add|post|display}"
    #            exit 1
    #    esac
    done
else
    echo "Invalid parameters given"
fi

