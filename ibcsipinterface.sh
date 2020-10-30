#!/usr/bin/bash

input="customlist"

for i in $(cat $input); do
   name="$i"
   ./getibcipforname.sh $name
   ipn=$(cat ipaddress)
   ./ibcsipinterface.exp $ipn >> $name-sipinterface.txt
   sed --in-place '/spawn/d' $name-sipinterface.txt
   sed --in-place '/user/d' $name-sipinterface.txt
   sed --in-place '/Warning/d' $name-sipinterface.txt
   sed --in-place '/This system/d' $name-sipinterface.txt
   sed --in-place '/Parent-v4/d' $name-sipinterface.txt
   sed --in-place '/iBGCFCore/d' $name-sipinterface.txt
   sed --in-place '/AMAZON_UNTRUSTED/d' $name-sipinterface.txt
   sed --in-place '/Transcode/d' $name-sipinterface.txt
   sed --in-place '/exit/d' $name-sipinterface.txt
done
   cat *.txt >> sip-interface.txt
   rm -rf *.txt

