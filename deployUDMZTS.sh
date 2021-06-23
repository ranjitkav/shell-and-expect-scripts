#!/bin/bash
###############################################
##  Written by : Ranjit Avasarala             #
##    email: ranjit.avasarala.ext@nokia.com   #
###############################################

# check if files exists
function checkfile
{
    if [ `ls -lrt | grep -c $1` -gt 0 ]
    then
        echo "File $1 exists"
    else
        echo "File $1 does not exist"
        exit
    fi
}

#check ZTS specific files
function checkZTSfiles
{
   # change to UDM namespace directory
   version=`cat udmversion.txt`
   namespace=`cat udmnamespace.txt`
   cd /root/$namespace/"UDM"$version
   echo "Current directory is: `pwd`"

   #check if required files are present
   input="ZTSfileslist.txt"
   if [ -z "$input" ]
   then
      echo "$input file is empty, deployment cannot proceed!!!"
      exit
   fi
   echo "Checking if required files for ZTS are present..."
   for line in $(cat $input);do
      file=`echo $line | cut -f2 -d":"`
      if [ ! -z "$file" ]
      then
         checkfile $file
      fi
   done 
}

#check UDM specific files
function checkUDMfiles
{
   # change to UDM namespace directory
   version=`cat udmversion.txt`
   namespace=`cat udmnamespace.txt`
   echo "namespace is: $namespace"
   cd /root/$namespace/"UDM"$version
   echo "Current directory is: `pwd`"
   
   #check if required files are present
   input="UDMfileslist.txt"
   if [ -z "$input" ]
   then
      echo "$input file is empty, deployment cannot proceed!!!"
      exit
   fi
   echo "Checking if required files for UDM are present..."
   for line in $(cat $input);do
      file=`echo $line | cut -f2 -d":"`
      if [ ! -z "$file" ]
      then
         #if line contains comma
         count=`echo $file | tr -cd , | wc -c`
         if [ $count -gt 0 ]
         then
            END=$(($count + 2))
            for ((i=1;i<END;i++));do
               checkfile `echo $file | cut -f$i -d","`
            done
         else
            checkfile $file
         fi
      fi
  done
}

#get option from stdin
function deploymentPreCheck
{
   echo "Section 8.1 of MOP : Deployment Pre Check....."
   # get UDM version that is being deployed
   echo "Get the UDM version"
   read version
   > udmversion.txt
   echo $version >> udmversion.txt

   #get sitename
   site=`hostname | awk '{print substr( $0, 5,2 )}'`

   #build UDM namespace
   > udmnamespace.txt
   echo "vudmcl01"$site"01" >> udmnamespace.txt
}

#check any remaining files
function checkremainingfiles
{
   # check contents of tar file
   echo "contents of secrets.tar are:"
   tar -tvf *secrets*.tar | egrep "config-|passwd-|pem"

   # cluster specific variables
}

#unpack ZTS and check files
function unpackZTSandHelm
{
   echo "Section 8.2 - Unpacking ZTS Image and Helm chart"
   tar -xvzf zts_release_*.tar.gz
   cd zts_release_*;tar -xvf lcmcli_packages.tar.gz
   cd helm_package; ls -lrt   
   # COPY and replace the ZTS deployment.cfg file created offline
   cd ../LCM_CLI
   #check if ORIG file exists
   if [ ! -f "ztsdeployment.cfg_ORIG" ]
   then
      cp ztsdeployment.cfg ztsdeployment.cfg_ORIG
   fi
   cp ../../*_ztsdeployment.cfg .

}
#cleanup
function cleanup
{
   rm -rf udmversion.txt
   rm -rf udmnamespace.txt
}

# initialize to get options
function initialize
{
   echo "Make sure the UDMfileslist.txt and ZTSfileslist.txt contain the list of files that need to be present"
   echo "Else deployment cannot proceed"
   echo "What you want to deploy: UDM or ZTS?"
   read option
   deploymentPreCheck
   case $option in
      "UDM")
      checkUDMfiles
      ;;
      "ZTS")
      checkZTSfiles
      ;;
      *)
      echo "Invalid Option"
      exit
      ;;
   esac
}

#### main ####
initialize
checkremainingfiles
unpackZTSandHelm
cleanup
