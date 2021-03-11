#!/bin/bash

input="all-nodes.txt"
todaydate=$(date +"%b   "%d)

for item in $(cat $input); do
   for ip in $(cat $item); do
      ipadd=`echo $ip | cut -f1 -d","`
      echo $ipadd
      if [[ $todaydate =~ 01 || $todaydate =~ 02 || $todaydate =~ 03 || $todaydate =~ 04 || $todaydate =~ 04 || $todaydate = 05  || $todaydate =~ 06 || $todaydate =~ 07 || $todaydate =~ 08 || $todaydate =~ 09 ]]; then
         tdate=`echo $todaydate | sed 's/0/  /g'`
      else
         tdate=$todaydate
      fi
      ./fetchvarlogmessages.exp $ipadd $tdate
      #zip consolidated-logs.zip logs/$ipadd-messages.log
   done
done

