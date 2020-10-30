#!/bin/bash

name="$1"

./getibcipforname.sh $name
input=$(cat ipaddress)

echo $input

echo "Executing post CR check on $name"
./labcustomcmd.exp $input

echo "Done"
