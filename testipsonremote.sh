#!/bin/bash

function processnode
{
  #send remotescript
  echo "==========================================================="
  echo "Performing ping check to all RDS IPs from first node only: $1"
  echo $2 >> nodetype.txt
  scp -q remoteipsping.sh $1:/root
  scp -q nodetype.txt $1:/root
  scp -q ips2ping.txt $1:/root
  ssh -q $1 "chmod u+x /root/remoteipsping.sh"
  ssh -q $1 "sh /root/remoteipsping.sh"
  rm -rf nodetype.txt
}

function getnodes
{
   # get name
   name=`kubectl get ns | grep -i vudm | cut -f1 -d" "`
   # get nodes list into file
   kubectl get pod -n$name -owide | egrep "ee|ucm|sdm|ueauth" | tr -s ' ' > nodes.txt
   # remove spaces and replace with ; for cut
   sed -i 's/ /;/g' nodes.txt
   input="nodes.txt"
   # get individual nodes and process them
   for line in $(head -1 $input);do
       # get nodename
       nodename=`echo $line | cut -f7 -d";"`
       # get nodetype and then format
       nodetype=`echo $line | cut -f1 -d";" | cut -f2 -d"-"`
       # remove udm from nodetype
       nodetype=${nodetype:3}
       # append -mcc to nodetype
       nodetype=$nodetype-"mcc"
       count=`grep -c "ueauthn" <<< $nodetype`
       if [ $count -gt 0 ]; then
	  # remove last n character
          nodetype=${nodetype::-1}
       fi
       # processnode with nodename and nodetype
       processnode $nodename $nodetype
       # remove the temp variables
       rm -rf nodetype
       rm -rf nodename
   done 
  
}

function cleanup
{
   rm -rf nodes.txt
   ssh -q $1 "rm -rf remoteipsping.sh"
}

#### main ####
getnodes 
cleanup 
