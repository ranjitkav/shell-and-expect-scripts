#!/bin/bash

pwd

#get list of ibcs
echo "Getting list of ibcs"
input="ibcslist"

echo "Begin loop"
for i in $(cat $input); do
  name="$i"
  echo "getting ip for ibc"
  ./getibcipforname.sh $name
  input1=$(cat ipaddress)
  echo "Executing multi cmds on $name"
  ./ibcmulticmd.exp $input1 
done

