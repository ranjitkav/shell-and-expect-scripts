#!/bin/bash

name="$1"
ip=0

rm -rf ipaddress

#echo "name is $name"
if [ `cat ibcnameip | grep -c $name` != "0" ]; then
     #echo "$name exists, get ip"
     ip=`cat ibcnameip | grep $name | cut -f2 -d','`
fi

#echo "ip is $ip"
echo $ip >> ipaddress

