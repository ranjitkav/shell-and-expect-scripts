#!/bin/bash

totest=1

# add ips - fetched from ips2add.txt
function addip4ldap
{
   nsenter --target $1 --net ip r add $2 via $3 dev ldap
}

# delete added ips 
function delip4ldap
{
   echo "Deleting route to $2"
   nsenter --target $1 --net ip r del $2 via $3 dev ldap
   totest=0
}

# test added ips
function testaddedip
{
    # get the output to a text file for parsing
    nsenter --target $1 --net ip a > ipinfo.txt
    while read line; do
       if grep -q "scope global ldap" <<< "$line"; then
          ldapip=`echo $line | cut -f2 -d" " | cut -f1 -d"/"`
       fi
    done < ipinfo.txt
    #echo "LDAP IP is: $ldapip"
    #echo "Pinging $3 from $ldapip"
    # get status
    input="targetgwip.txt"
    TERM=xterm
    for ip in $(cat $input); do
       status=`nsenter --target $1 --net -- ping -c3 -I $ldapip $ip &> /dev/null && echo -e "\033[32mreachable\033[0m" || echo -e "\033[31munreachable\033[0m"`
       echo "Gateway with IP: $ip is $status from $ldapip"
    done
}

# get ldap ip from ipinfo.txt
function getldapip
{
   #use while loop to read the whole line
   #for loop considers space as a delimiter
   while read line;do
      # check for the presence of scope global ldap which is unique
      # and grab that line to get ldap ip
      if grep -q "scope global ldap" <<< "$line";then
         ldapip=`echo $line | cut -f2 -d" " | cut -f1 -d"/"`
      fi
   done < $2
}

# get docker container and process ids
function getdockerpid
{
    nodetype=`cat nodetype.txt`
    echo "nodetype before docker ps is: $nodetype"
    # get container id
    echo "running command: docker ps | grep -i $nodetype"
    cid=`docker ps | grep -i $nodetype | tr ' ' ';' | cut -f1 -d";"`
    echo "container id after docker ps is: $cid"
    # get pid using container id
    processid=`docker inspect $cid | grep -i pid | cut -f2 -d":"| cut -f1 -d","`
    pid=`echo $processid | cut -f1 -d" "`
    echo "pid after docker inspect is: $pid"
    nsenter --target $pid --net ip a > ipinfo.txt
    gwip=`cat gwip.txt`

    #read option
    option=`cat option.txt`
    #extract ips to add/delete
    input="ip2add.txt"
    #echo "Option is: $option"
    for ip in $(cat $input);do
        if [ $option == "1" ]; then
           addip4ldap $pid $ip $gwip
        else 
           # its delete
           delip4ldap $pid $ip $gwip
        fi
    done
    # pingtest only if the operation is add
    #echo $totest
    if [ $totest == 1 ]; then
       testaddedip $pid
    fi
}

function cleanup
{
    rm -rf ipinfo.txt nodetype.txt ip2add.txt targetgwip.txt option.txt
}

# main #
getdockerpid
#cleanup
