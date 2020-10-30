#!/usr/bin/bash

input="customlist"

for i in $(cat $input); do
   name="$i"
   ./getibcipforname.sh $name
   ipn=$(cat ipaddress)
   ./ibcshrunconfig.exp $ipn >> $name-shrunningconfig.txt
   zip shrunning.zip $name-shrunningconfig.txt
   rm -rf $name-shrunningconfig.txt
done
   mailx -s "running config" -a shrunning.zip ra698k@att.com -c ra698k@att.com < /dev/null
   rm -rf shrunning.zip
