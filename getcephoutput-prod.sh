#!/bin/bash

input="prod-IPs"

for line in $(cat $input); do
  ipadd=`echo $line | cut -f1 -d","`
  user=`echo $line | cut -f3 -d","`
  timeout 5 ssh -t -t -o StrictHostKeyChecking=no $user@$ipadd <<EOI
o 1
ceph osd df
exit
EOI
done
