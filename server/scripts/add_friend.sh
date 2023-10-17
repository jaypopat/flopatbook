#!/bin/bash

userID=$1
friendToAdd=$2

cd ../users

if [  -d "$userID" ]; then :  # echo "you exist"
else echo "nok: user $userID does not exist" && exit
fi
if [  -d "$friendToAdd" ]; then : # echo "$friendToAdd exists in usersList"
else echo "nok: $friendToAdd does not exist in friendList" && exit
fi
if grep "$friendToAdd" "$userID/friendList.txt" > /dev/null; then echo "$friendToAdd already in friendList"
else echo "friend not in friend list -- adding to friendList" && echo $friendToAdd >> "$userID/friendList.txt"
fi