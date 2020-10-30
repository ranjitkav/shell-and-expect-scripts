#!/usr/bin/bash

input="seatlelist"

for i in $(cat $input); do
  name="$i"

  ./getibcipforname.sh $name
  input1=$(cat ipaddress)

  echo $input1

  echo "Executing health check on $name"
  ./ibccheckhealth.exp $input1
done
