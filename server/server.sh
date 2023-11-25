#!/bin/bash

while true; do 
    cd ../pipes

    read input < server.pipe
    set -- $input

    echo $input

    request=$1
    id=$2

    echo $request
    cd ../server/scripts

    case $request in
        create)
            if [ $# -gt 2 ]; then 
                cd ../../pipes 
                echo "ERROR: Permission denied- User $id cannot create new users" > $id.pipe
                continue
            fi

            cd ../users

            if [ ! -d "$id" ]; then

                cd ../scripts
                ./create.sh $id

                cd ../../pipes
                echo "SUCCESS: $id user created" > $id.pipe
            else
                cd ../../pipes
                echo "ERROR: User $id already exists" > $id.pipe
            fi
            ;;
        add)
            
            if [ ! $# -eq 3 ]; then

                cd ../../pipes 
                echo "ERROR: Invalid number of arguments" > $id.pipe
                continue
            fi

            friendToAdd=$3

            cd ../users

            if [ "$id" = "$friendToAdd" ]; then
                cd ../../pipes
                echo "ERROR: cannot add yourself" > $id.pipe
                continue
            fi

            if [ ! -d "$friendToAdd" ]; then

                cd ../../pipes
                echo "ERROR: $friendToAdd does not exist" > $id.pipe
                continue
            fi

            if grep "$friendToAdd" "$id/friendList.txt" > /dev/null; then

                cd ../../pipes
                echo "ERROR: $friendToAdd already in friend list" > $id.pipe
                continue
            fi

            cd ../scripts
            ./add_friend.sh $id $friendToAdd

            cd ../../pipes
            echo "SUCCESS: $friendToAdd added to $id friend list" > $id.pipe
            ;;
        post)
            if [ $# -lt 4 ]; then

                cd ../../pipes
                echo "ERROR: Invalid number of arguments" > $id.pipe
                continue
    
            fi

            receiver=$3
            message=$4

            cd ../users

            if [ ! -d "$receiver" ]; then 

                cd ../../pipes
                echo "ERROR: user $receiver does not exist" > $id.pipe
                continue

            fi

            if ! grep -qF "$id" "$receiver/friendList.txt" && [ $id != $receiver ]; then # if sender not on receiver friend list and if not displaying own wall
                cd ../../pipes
                echo "ERROR: user $id not on $receiver friend list!" > $id.pipe
                continue
            fi


            if [ -n "$5" ]; then
                for arg in "${@:5}"; do
                    message+=" $arg"
                done
            fi

            cd ../scripts
            ./post_messages.sh $id $receiver "$message"

            cd ../../pipes
            echo "SUCCESS: Message added to $receiver wall" > $id.pipe
            ;;
        display)

            if [ $# -ne 3 ]; then
                cd ../../pipes
                echo "ERROR: Invalid number of arguments" > $id.pipe
                continue
            fi

            cd ../users

            userID=$3

            if [ ! -d "$userID" ]; then
                cd ../../pipes
                echo "ERROR: user $userID does not exist" > $id.pipe
                continue
            fi

            output=""

            output+=`cat $userID/wallFile.txt`

            cd ../../pipes
            echo "$output" > $id.pipe
            ;;
        *)
            cd ../../pipes
            echo "ERROR: Invalid request!" > $id.pipe
            ;;
    esac
done