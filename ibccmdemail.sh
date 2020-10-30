#!/bin/bash

#get list of ibcs
input="ibcslist"

for i in $(cat $input); do
  name="$i"
  ./getibcipforname.sh $name
  input1=$(cat ipaddress)
  echo "Executing multi cmds on $name"
  ./ibccustomcmd.exp $input1 >> $name-ssm-accelerator-output
  zip sh-security-accelerator.zip $name-ssm-accelerator-output
  rm -rf $name-ssm-accelerator-output
done
  mailx -s "show security ssm-acceletor output" -a sh-security-accelerator.zip ra698k@att.com -c ra698k@att.com < /dev/null
  rm -rf sh-security-accelerator.zip

