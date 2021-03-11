#!/bin/bash

for i in `cat hosts.all | egrep -v "PGW|ADM|DBM"`
do
sshcheck=`ssh sdfrun@$i -o StrictHostKeyChecking=no "echo $i"`
[ ! -z "$sshcheck" ] && echo "ssh success for" $i || echo "ssh failed for" $i
done


for i in `cat hosts.all | egrep "PGW"`
do
sshcheck=`ssh provgw@$i -o StrictHostKeyChecking=no "echo $i"`
[ ! -z "$sshcheck" ] && echo "ssh success for" $i || echo "ssh failed for" $i
done

for i in `cat hosts.all | egrep "ADM|DBM"`
do
sshcheck=`ssh dbmrun@$i -o StrictHostKeyChecking=no "echo $i"`
[ ! -z "$sshcheck" ] && echo "ssh success for" $i || echo "ssh failed for" $i
done