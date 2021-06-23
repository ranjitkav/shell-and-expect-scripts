#!/bin/bash

function getlistofxml
{
    ls -ltr vudmcl*.xml | awk '{print $9}' > source_xml.txt
}

function newoutputfile
{
    input="source_xml.txt"
    for line in $(cat $input);do
       file=`echo $line | cut -f1 -d"."`
       cat file1.txt >> $file"_config.xml"
       cat $line >> $file"_config.xml"
       cat file2.txt >> $file"_config.xml"
       cat $line >> $file"_config.xml"
       cat file3.txt >> $file"_config.xml"
       cat $line >> $file"_config.xml"
       cat file4.txt >> $file"_config.xml"
       cat $line >> $file"_config.xml"
       cat file5.txt >> $file"_config.xml"
    done
}

function write2outputfile
{ 
    echo "writing to output file: $3.xml" 
    echo "<HostConfigTable>" >> $3.xml
    echo "<Host>$1</Host>" >> $3.xml
    echo "<PriorityValue>$2</PriorityValue>" >> $3.xml
    echo "<CapacityValue>1</CapacityValue>" >> $3.xml
    echo "<PortValue>16611</PortValue>" >> $3.xml
    echo "</HostConfigTable>" >> $3.xml
}

function readudmnode
{
   input="updated-data.csv"
   for line in $(cat $input);do
      # get udm node name
      udm=`echo $line | cut -f1 -d","`
      # get priority values, nodes and their IPs
      prioVal=`echo $line | cut -f2 -d"," | cut -f1 -d":" | cut -f2 -d"-"`
      # get number of SR nodes for this priority value
      line1=`echo $line | cut -f2 -d":"`
      count=`echo $line1 | grep -o "SR" | wc -l`
      # assign END to count
      END=$(($count + 1))
      # run for loop to get individual SR nodes
      # start from 3rd field
      for ((i=1;i<END;i++)); do
          node=""
          node=`echo $line1 | cut -f"$i" -d","`
          # lookup this node for its ip
          line2=`grep $node tmpfile`
          ip=`echo $line2 | cut -f2 -d";"`
          if [ -z "$ip" ]; then
             ip="IP_NOT_FOUND_FOR_$node"
          fi
          # write to output - ip, priorityval
          # give filename as udm node
          # get priority values, nodes and their IPs
          write2outputfile $ip $prioVal $udm
      done
   done
}

function convert2csv
{
    while read line
      do
        echo $line | tr ' ' ';' >> tmpfile
    done <  srdafull_list_name_ip.txt
}

function cleanup
{
   rm -rf tmpfile
}

function initialize
{
   rm -rf vudm*.xml
}

### main ###
initialize
convert2csv
readudmnode
getlistofxml
newoutputfile
cleanup



