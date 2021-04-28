#!/bin/bash

input="lab-IPs"

function doextrasteps {
  password="kLj*Hp@2NQ0!Z#"
  ./getcephoutput1.exp $1 $password
}

for line in $(cat $input); do
  ipadd=`echo $line | cut -f1 -d","`
  if [ $ipadd = "10.145.188.68" ] 
  then
     doextrasteps $ipadd
  else
     password="O6S-R1Qa*ws4vdT1s!"
     ./getcephoutput.exp $ipadd $password
  fi 
done

