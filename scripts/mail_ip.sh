#!/bin/sh
#
# Based on https://www.raspberrypi.org/forums/viewtopic.php?t=65010
#
# 


SUBJ="IP"
EMAIL="email@your.address"

ip1=""
ip2=""

read ip1 < ip.txt

ip2=$(curl -sS ifconfig.me/ip)

if [ -z "$ip2" ]
then
  exit
else
  if [ "$ip1" = "$ip2" ]
  then
    exit
  else
    echo "$ip2" > ip.txt
    echo "$ip2" | mail -s $SUBJ $EMAIL
    exit
  fi
fi

