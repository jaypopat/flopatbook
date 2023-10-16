#!/bin/bash

userID=$1
friendToAdd=$2

cd users

if [  -d "$userID" ]; then
    echo "you exist"
else 
    echo "nok: user ’$userID’ does not exist"
    exit
fi

if [  -d "$friendToAdd" ]; then
    echo "$friendToAdd exists in friendList"
else 
    echo "nok: $friendToAdd does not exist in friendList"
    exit
fi

if grep "$friendToAdd" "$userID/friendList.txt" > /dev/null; then
    isSuccess=$?
    echo $isSuccess
    if [ $isSuccess -eq 0 ]; then
        echo "friend detected"
    else
        echo "not a friend"
    fi
else
    echo "friend not in friend list"
    echo -e $friendToAdd >> "$userID/friendList.txt"
fi