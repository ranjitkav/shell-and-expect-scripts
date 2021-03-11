#!/usr/bin/python

import glob
import os
from datetime import datetime

# execute on shell
def oscommand(cmd):
   os.system(cmd)

# compress and delete the file
def compressfiles():
   cmd="zip consolidated-logs.zip"+" logs/*"
   os.system(cmd)
   cmd="rm -rf logs/*"

# get logs from adm node
def getfilesfromadm(ipadd):
   cmd="./fetchfromadm.exp"+" "+ipadd
   os.system(cmd)

# get logs from pgd node
def getfilesfrompgd(ipadd):
   # need to fetch from multiple instances 
   numinstances = 2
   for item in range(numinstances):
      cmd="./fetchfrompgd.exp"+" "+ipadd+" "+str(item)
      os.system(cmd)

# logs from adm nodes
def fetchfromadm():
   with open("adm-nodes.txt") as fd:
      line = fd.readline()
      while line:
        for item in line.split(","):
           ipadd=item
           getfilesfromadm(ipadd)
           cmd="mv statusservice.log relay.log probe.log logs/" 
           compressfiles()
        line = fd.readline() 

# fetch from SR,CBE, PGW an PGD nodes
def fetchfromrdsbdsdevpgd(ipadd):
   todaydate=datetime.now().strftime('%d%m%Y')
   datetoday=datetime.now().strftime('%Y-%m-%d')
   cmd="./getlogs.exp "+ipadd+" "+todaydate+" "+datetoday
   os.system(cmd)
   cmd1="mv af02_* af03_* connectivity.log synchronisation.log failover.log logs/"
   os.system(cmd1)
   compressfiles()

# process input file to get list of files
def processfile(file):
   with open(file, "r") as fd:
      line = fd.readline()
      while line:
        for item in line.split(","):
           ipadd=item
           fetchfromrdsbdsdevpgd(ipadd)
           break
        line = fd.readline()


#fetch files from pgd
def fetchfrompgd():
   with open("pgd-nodes.txt", "r") as fd:
       line = fd.readline()
       for item in line.split(","):
           ipadd=item
           getfilesfrompgd(ipadd)
           cmd="mv *.log logs/"
           os.system(cmd)
           compressfiles()
           break
       line = fd.readline()

#getvarlogmessages
def getvarlogmessages(ipadd):
   today=datetime.now()
   month=datetime.now().strftime("%B")
   mon=month[0:3]
   cmd="./getvarlogmessages.exp "+ipadd+" "+str(mon)+"  "+str(today.day)
   print(cmd)
   os.system(cmd)
   compressfiles()
   

# process input file to get list of files
def processeachfile(file):
   with open(file, "r") as fd:
      line = fd.readline()
      while line:
        for item in line.split(","):
           ipadd=item
           print(ipadd)
           getvarlogmessages(ipadd)
           break
        line = fd.readline()

#fetch var/log/messages for current date
def fetchvarlogmessages():
   with open("all-nodes.txt", "r") as fd:
      line = fd.readline()
      while line:
         for item in line.split(","):
            #print("file name is:", item.rstrip("\n"))
            processeachfile(item.rstrip("\n"))
            break
         line = fd.readline()

# main function
if __name__ == "__main__":
   with open("aflogfilelist.txt", "r") as fd:
        line = fd.readline()
        while line:
           line = line.rstrip("\n")
           processfile(line)
           line = fd.readline()
   # fetch from adm
   fetchfromadm()
   # fetch frompgd
   fetchfrompgd()
   # fetch var/log/messages
   fetchvarlogmessages()
   

