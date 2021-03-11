#!/bin/bash

cat /etc/hosts | grep -i sr >> sr-nodes.txt
cat /etc/hosts | grep -i cb >> cb-nodes.txt
cat /etc/hosts | grep -i ban >> ban-nodes.txt
cat /etc/hosts | grep -i pcs >> pcs-nodes.txt
cat /etc/hosts | grep -i dev >> dev-nodes.txt
cat /etc/hosts | grep -i pgd >> pgd-nodes.txt
cat /etc/hosts | grep -i pgw >> pgw-nodes.txt

