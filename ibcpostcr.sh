#!/usr/bin/bash

name="$1"

pwd

./getibcipforname.sh $name
input=$(cat ipaddress)

echo $input

echo "Executing post CR check on $name"
./ibcpostcr.exp $input

echo "Done"
