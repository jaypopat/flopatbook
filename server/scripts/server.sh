#!/bin/bash


while true; do
   read -p "Enter request and arguments: " command
   set -- $command
   case "$1" in
       create)
           ./create.sh $2
           ;;
       add)
           ./add_friend.sh $2 $3
           ;;
       post)
           if [ -n "$5" ]; then
            message="$4"
            for arg in "${@:5}"; do
                message+=" $arg"
            done
                ./post_messages.sh $2 $3 "$message"
            else
                ./post_messages.sh $2 $3 "$4"
            fi
           ;;
       display)
            echo -e "\n"
           ./display_wall.sh $2
           echo -e "\n"
           ;;
       *)
           echo "Accepted Commands: {create|add|post|display}"
           exit 1
   esac
done

