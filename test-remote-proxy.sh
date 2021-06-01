#!/bin/bash

function testproxyip {
  ssh -q -i /var/log/nsncare/KEYS/id-sam-rsa -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no stack@$1 "ping -c3 $2 &> /dev/null && echo 'Proxy IP: $2 is reachable' || echo 'Proxy IP:$2 is unreachable'"

}

input="remote-ips.txt"

for line in $(cat $input); do
  ip=`echo $line | cut -f2 -d","`
  proxyip=$(awk -F\. '{ print $1"."$2"."$3"."$4+1 }' <<< $ip)
  testproxyip $ip $proxyip

done