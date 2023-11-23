#!/bin/bash

sender=$1
receiver=$2
message=$3

cd ../users

# if [ $# -ne 3 ]; then
#     echo "nok: use format ./post_messages.sh <sender> <receiver> <message>"
#     exit 1
# fi

# if [ -d "$sender" ]; then :  # echo "you exist"
# else echo "nok: user $sender does not exist" && exit
# fi

# if [ -d "$receiver" ]; then :  # echo "you exist"
# else echo "nok: user $receiver does not exist" && exit
# fi

echo "$sender: $message" >> $receiver/wallFile.txt