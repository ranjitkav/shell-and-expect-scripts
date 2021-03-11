#! /bin/sh

eval `ssh-agent`
ssh-add /export/home/sufuser/.ssh/id_rsa

checklist_path=/ISS/upgrade16_17/daily-checklist/
date=$(date +"%Y-%m-%d_%H:%M:%S")
mkdir -p $checklist_path
for i in `cat /export/home/sufuser/Pre-Post/hosts.all | grep -i ADMCH001` ; do
        scp -r /export/home/sufuser/Pre-Post/getssh.sh root@$i:/opt/dbm/getssh/
        scp -r /export/home/sufuser/Pre-Post/hosts.all root@$i:/opt/dbm/getssh/
        ssh root@$i "chmod 777 /opt/dbm/getssh/getssh.sh; chmod 755 /opt/dbm/getssh/hosts.all"
        ssh root@$i "cd /opt/dbm; su - dbmrun /opt/dbm/getssh/getssh.sh > /tmp/1.txt; cat /tmp/1.txt" > $checklist_path/getssh-$i-$date.txt;
        ssh root@$i "rm -rf /tmp/1.txt"
        cat $checklist_path/getssh-$i-$date.txt
done