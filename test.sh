#!/bin/bash

input="all-nodes.txt"
todaydate=$(date +"%b"%d)

#if [ $todaydate ?? '01' || '02' || '03' || '04' || '05' || '06' || '07' || '08' || '09' ]; then

ipadd=`echo $ip | cut -f1 -d","`
ipadd=5.232.107.103
if [[ $todaydate =~ 01 || $todaydate =~ 02 || $todaydate =~ 03 || $todaydate =~ 04 || $todaydate =~ 04 || $todaydate = 05  || $todaydate =~ 06 || $todaydate =~ 07 || $todaydate =~ 08 || $todaydate =~ 09 ]]; then
   tdate=`echo $todaydate | sed 's/0/ /g'`
else
   tdate=$todaydate
fi
echo $tdate
