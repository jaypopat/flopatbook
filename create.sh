#!/bin/bash

userID=$1

currDir=$(pwd)
mkdir $currDir/users/$1
touch $currDir/users/$1/friendList.txt 
touch $currDir/users/$1/wallFile.txt