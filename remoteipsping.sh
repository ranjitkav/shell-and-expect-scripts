#!/bin/bash

function testipsping
{
    nodetype=`cat nodetype.txt`
    echo "nodetype before docker ps is: $nodetype"
    # get container id
    cid=`docker ps | grep -i $nodetype | tr ' ' ';' | cut -f1 -d";"`
    # get pid using container id
    processid=`docker inspect $cid | grep -i pid | cut -f2 -d":"| cut -f1 -d","`
    pid=`echo $processid | cut -f1 -d" "`
    nsenter --target $pid --net ip a > ipinfo.txt
    # get the output to a text file for parsing
    nsenter --target $pid --net ip a > ipinfo.txt
    while read line; do
       if grep -q "scope global ldap" <<< "$line"; then
          ldapip=`echo $line | cut -f2 -d" " | cut -f1 -d"/"`
       fi
    done < ipinfo.txt
    #extract ips to test
    input="ips2ping.txt"
    for line1 in $(cat $input);do
        ip=`echo $line1 | cut -f2 -d":"`
        status=`nsenter --target $pid --net -- ping -c3 -I $ldapip $ip &> /dev/null && echo -e "\033[32mreachable\033[0m" || echo -e "\033[31munreachable\033[0m"`
        echo "RDS with IP: $ip is $status from $ldapip" 
    done
}

function cleanup
{
    rm -rf ipinfo.txt
    rm -rf nodetype.txt
    rm -rf ips2ping.txt
}

# main #
testipsping
cleanup
