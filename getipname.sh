#/bin/bash

awk '/hs0/ {print $1, $2}' /etc/hosts

