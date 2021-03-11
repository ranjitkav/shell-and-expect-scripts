#!/bin/bash

input="aflogfilelist.txt"
input="all-nodes.txt"

todaydate=$(date +"%d%m%Y")
datetoday=$(date +"%Y-%m-%d")

# fetch AF, synchronization, connectivity and failover logs from all nodes - except ADM
# add them to the zip
for item in $(cat $input); do
   for ip in $(cat $item); do
      ipadd=`echo $ip | cut -f1 -d","`
      #echo $ipadd
      # change local directory
      cd logs
      mkdir $ipadd 
      #excute expect
      /usr/bin/expect /export/home/sufuser/consolidatedlogs/getlogs.exp $ipadd $todaydate $datetoday
      # zip the log files
      zip consolidated-logs.zip logs/$ipadd/af02_alarm_log.$todaydate
      zip consolidated-logs.zip logs/$ipadd/af03_stats_log.$todaydate
      zip consolidated-logs.zip logs/$ipadd/synchronisation.log
      zip consolidated-logs.zip logs/$ipadd/connectivity.log
      zip consolidated-logs.zip logs/$ipadd/failover.log
      rm -rf $ipadd/*
      rmdir $ipadd
   done
done

# fetch SS logs from adm
# ./fetchfromadm.sh 
# fetch NTFlogs from pgd nodes
# ./fetchfrompgd.sh
# fetchvarlogmessages
# ./fetchvarlogmessages.sh
