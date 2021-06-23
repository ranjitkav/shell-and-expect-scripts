#!/bin/bash

function getIPslist
{
    name=`echo $1 | cut -f1 -d"_"`
    > IPs2Delete.txt
    grep "<Host>" $1 | cut -f2 -d">" | cut -f1 -d"<" | sort | uniq > IPs2delete.txt
    filename="$name""_delete.xml"
    buildDeletefile IPs2delete.txt $filename  
    rm -rf IPs2delete.txt
}

function buildDeletefile
{
    input="$1"
    # build the xml file
    echo "<edit-config>" >> $2
    echo "<target>" >> $2
    echo "<candidate/>" >> $2
    echo "</target>" >> $2
    echo "<config xmlns='http://tail-f.com/ns/config/1.0'>" >> $2
    echo "<REGISTERS xmlns='http://nokia.com/REGISTERS'>" >> $2
    # UDM UECM
    echo "<UDM_UECM xmlns='http://nokia.com/UDM_UECM'>" >> $2
    # add IPs 
    for ip in $(cat $input);do
       echo "<UdmUecmLdapInterface>" >> $2
       echo "<HostConfigTable operation='delete'>" >> $2
       echo "<Host>$ip</Host>" >> $2
       echo "</HostConfigTable>" >> $2
       echo "</UdmUecmLdapInterface>" >> $2
    done
    echo "</UDM_UECM>" >> $2

    # UDM EE 
    echo "<UDM_EE xmlns='http://nokia.com/UDM_EE'>" >> $2
    # add IPs 
    for ip in $(cat $input);do
       echo "<UdmEeLdapInterface>" >> $2 
       echo "<HostConfigTable operation='delete'>" >> $2
       echo "<Host>$ip</Host>" >> $2
       echo "</HostConfigTable>" >> $2
       echo "</UdmEeLdapInterface>" >> $2
    done
    echo "</UDM_EE>" >> $2

    echo "<UDM_SDM xmlns='http://nokia.com/UDM_SDM'>" >> $2
    # add IPs 
    for ip in $(cat $input);do
       echo "<UdmSdmLdapInterface>" >> $2
       echo "<HostConfigTable operation='delete'>" >> $2
       echo "<Host>$ip</Host>" >> $2
       echo "</HostConfigTable>" >> $2
       echo "</UdmSdmLdapInterface>" >> $2
    done
    echo "</UDM_SDM>" >> $2

    
    echo "<UEAUTHN xmlns='http://nokia.com/UEAUTHN'>" >> $2
    # add IPs 
    for ip in $(cat $input);do
       echo "<UeAuthnLdapInterface>" >> $2
       echo "<HostConfigTable operation='delete'>" >> $2
       echo "<Host>$ip</Host>" >> $2
       echo "</HostConfigTable>" >> $2
       echo "</UeAuthnLdapInterface>" >> $2

    done
    echo "</UEAUTHN>" >> $2
    echo "</REGISTERS>" >> $2
    echo "</config>" >> $2
    echo "</edit-config>" >> $2
}

function cleanup
{
   rm -rf *.IPs2delete.txt

}

function initialize
{
   rm -rf configfilelist.txt
   rm -rf *_delete.xml

}

function readxmlfiles
{
   ls -ltr vudmcl*_config.xml | awk '{print $9}' >> configfilelist.txt
   # for each file, get IPs and build delete file
   input="configfilelist.txt"
   for file in $(cat $input); do
      getIPslist $file
   done  
}

#main code
initialize
readxmlfiles
cleanup
