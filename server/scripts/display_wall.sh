#!/bin/bash

userID=$1

cd ../users

# if [ $# -ne 1 ]; then
#     echo "nok: use format ./display_wall.sh <user>"
#     exit 1
# fi

echo -e "\n"
cat $userID/wallFile.txt
echo -e "\n"
