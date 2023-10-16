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

if grep "ˆ$friend" "$userID"/friendList.txt > /dev/null; then
    echo "exit code true so"
else
    echo "falsoo"
fi