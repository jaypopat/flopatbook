#!/bin/bash

userID=$1
friendToAdd=$2

cd users

if [  -d "$userID" ]; then
    echo "you exist"
else 
    echo "nah he dont exist"
fi

if [  -d "$friendToAdd" ]; then
    echo "friend exists"
else 
    echo "nah he dont exist"
fi

# cat "$userID/friendList.txt"
if grep "ˆ$friendToAdd" "$userID/friendList.txt" > /dev/null; then
    isSuccess=$?
    echo $isSuccess
    if [ $isSuccess -eq 0 ]; then
        echo "friend detected"
    else
        echo "not a friend"
    fi
else
    friendName=$(cat "$userID/friendList.txt")
    if [[ $friendName == $friendToAdd ]]; then
        echo "friend detected"
    echo "exiting loop"
    fi
fi

