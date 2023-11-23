#!/bin/bash

id=$1

read input < ../../pipes/server.pipe
set -- $input

request=$1


case $request in
    create)
        ./create.sh $id
        ;;
    add)
        
        if [ ! $# -eq 2 ]; then

            echo "ERROR: Invalid number of arguments" > ../pipes/$id.pipe

        fi

        friendToAdd=$2

        cd ../users

        if [ ! -d "$id" ]; then  

            echo "ERROR: user $id does not exist" > ../pipes/$id.pipe

        fi

        if [ ! -d "$friendToAdd" ]; then

            echo "ERROR: $friendToAdd does not exist in friendList" > ../pipes/$id.pipe

        fi

        if grep "$friendToAdd" "$id/friendList.txt" > /dev/null; then

            echo "ERROR: $friendToAdd already in friendList" > ../pipes/$id.pipe

        fi

        ./add_friend.sh $id $friendToAdd
        echo "SUCCESS: $friendToAdd added to $id friend list" > ../pipes/$id.pipe
        ;;
    post)
        if [ $# -lt 3 ]; then

            echo "ERROR: Invalid number of arguments" > ../pipes/$id.pipe
 
        fi

        receiver=$2
        message=$3


        if [ ! -d "$id" ]; then 

            echo "ERROR: user $id does not exist" > ../pipes/$id.pipe

        fi

        if [ ! -d "$receiver" ]; then 

            echo "ERROR: user $receiver does not exist" > ../pipes/$id.pipe

        fi

        ./post_messages.sh $id $receiver $message
        echo "SUCCESS: Message added to $receiver wall" > ../pipes/$id.pipe
        ;;
    display)

        if [ $# -ne 1 ]; then

            echo "ERROR: Invalid number of arguments" > ../pipes/$id.pipe
 
        fi

        ./display_wall.sh $id
        echo "SUCCESS: $id wallFile.txt displayed!" > ../pipes/$id.pipe
        ;;
esac