#!/bin/bash

ip="$1"

echo "IP is $ip"

$num = `cat ibcnameip | grep -c $ip`
if $num > 0
then
   echo "$ip exists, get name"
   ibcn=`cat ibcnameip | grep $ip | cut -f1 -d','`
fi

echo $ibcn
