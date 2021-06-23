#!/bin/bash

function processnode
{
  #send remotescript
  echo "==========================================================="
  echo "Processing on node: $1"
  echo $2 >> nodetype.txt
  scp -q remoteipsping.sh $1:/root
  scp -q nodetype.txt $1:/root
  scp -q ips2ping.txt $1:/root
  scp -q option.txt $1:/root
  scp -q gwip.txt $1:/root
  scp -q targetgwip.txt $1:/root
  ssh -q $1 "chmod u+x /root/remotescript.sh"
  ssh -q $1 "sh /root/remotescript.sh"
  rm -rf nodetype.txt
}

function getnodes
{
   # get name
   name=`kubectl get ns | grep -i vudm | cut -f1 -d" "`
   #get gateway ip
   kubectl get danmnet -n $name ldap-lan -o yaml | grep -A1 routes | cut -f2 -d":" | grep 10. | tr -d ' ' > gwip.txt
   #get target gw ip to ping
   input="ip2add.txt"
   > targetgwip.txt
   for ip in $(cat $input); do
       ipadd=`echo $ip | cut -f1 -d"/"`
        targetgwip=$(awk -F\. '{ print $1"."$2"."$3"."$4+1 }' <<< $ipadd)
        echo $targetgwip >> targetgwip.txt
   done
   # get nodes list into file
   kubectl get pod -n$name -owide | egrep "ee|ucm|sdm|ueauth" | tr -s ' ' > nodes.txt
   # remove spaces and replace with ; for cut
   sed -i 's/ /;/g' nodes.txt
   input="nodes.txt"
   # get individual nodes and process them
   for line in $(cat $input);do
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
       nodetype=""
       nodename=""
       name=""
    done
    echo "========================================================"
    echo "Script execution complete, check output for any errors!"
  
}

function getoption
{
   echo "#-------------------------#"
   echo "#  Actions Menu           #"
   echo "#-------------------------#"
   echo "#                     #"
   while [ "x$selection" == "x" ]
    do
       echo "# 1 -  Add Routes     #"
       echo "# 2 -  Delete Routes  #"
       echo "#                     #"
       echo -e "Enter option --> \c" 
       read selection
    done

    case $selection in
       "1")
       echo "Adding Routes"
       echo $selection > option.txt
       ;;
       "2")
       echo "Deleting Routes"
       echo $selection > option.txt
       ;;
       *)
       echo "Invalid option"
       echo "Options can be 1 or 2 only"
       exit
       ;;
    esac
}

function cleanup
{
   rm -rf nodes.txt
   ssh -q $1 "rm -rf remotescript.sh"
}

#### main ####
getoption
getnodes 
cleanup
