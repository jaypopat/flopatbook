#!/bin/bash

userID=$1

if [ -z "$userID" ]; then
  echo "nok: no identifier provided"
  exit 1
fi

currDir=$(pwd)
currUser="$currDir/users/$userID"

if [ -d "$currUser" ]; then
    echo "nok: user already exists"
    exit 1
else
    mkdir -p "$currUser"
    echo "ok - user $userID created"
fi

touch "$currUser"/friendList.txt "$currUser"/wallFile.txt
