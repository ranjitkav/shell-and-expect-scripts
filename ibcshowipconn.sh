#!/usr/bin/bash

name="$1"

./getibcipforname.sh $name
input=$(cat ipaddress)

echo "Executing show ip connections on $name"
./ibcshowipconn.exp $input

echo "Done"
