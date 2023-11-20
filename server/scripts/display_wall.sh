#!/bin/bash

userID=$1

if [ $# -ne 1 ]; then
    echo "nok: use format ./display_wall.sh <user>"
    exit 1
fi

cat ../users/$userID/wallFile.txt
