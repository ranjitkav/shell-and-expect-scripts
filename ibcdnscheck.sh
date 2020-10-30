#!/bin/bash

#get list of ibcs
input="ibcslist"

for i in $(cat $input); do
  name="$i"
  ./getibcipforname.sh $name
  input1=$(cat ipaddress)
  echo "Executing multi cmds on $name"
  ./ibcdnscheck.exp $input1 
done

