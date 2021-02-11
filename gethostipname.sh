#/bin/bash

input="memrep-ips.txt"

echo "enter password:"
read pass

#password=$pass

# execute the script
for ip in $(cat $input); do
   #echo $ip
   sshpass -p $pass scp getipname.sh root@$ip:/Tspswrepo/memreport/getipname.sh
   sshpass -p $pass ssh root@$ip "sh /Tspswrepo/memreport/getipname.sh >> /Tspswrepo/memreport/ipname-$ip.txt"
   sshpass -p $pass scp root@$ip:/Tspswrepo/memreport/ipname-$ip.txt ipname-$ip.txt
   sshpass -p $pass ssh root@$ip "rm -rf /Tspswrepo/memreport/ipname-$ip.txt"
   sshpass -p $pass ssh root@$ip "rm -rf /Tspswrepo/memreport/getipname.sh"
done



