#!/bin/bash

input="pgd-nodes.txt"

numinstances=2

# fetch from adm
for item in $(cat $input); do
   ipadd=`echo $item | cut -f2 -d","`
   for i in $numinstances; do
       file1="/opt/notifs/logs/instance$i/notifs-discarded_letter.log.*"
       file2="/opt/notifs/logs/instance$i/notis-dead_letterlog.*"
       file3="/opt/notifs/logs/instance$i/notifs-counting.log.*"
       file4="/opt/notifs/logs/instance$i/notifs-config_data.log.*"
       file5="/opt/notifs/logs/instance$i/notifs-statistics.log.*"
       file6="/opt/notifs/logs/instance$i/notifs.log.*"
       ./fetchfrompgd.exp $ipadd $file $file2 $file3 $file4 $file5 $file6
       zip consolidated.zip logs/$ip/*
   done
done
