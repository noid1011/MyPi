#!/bin/bash
cd  ~/whoshome/

# load phones from config file
source whoshome.cfg

# Download router wifi page
curl http://192.168.0.1/sky_index.html > DevicesConnected.html

# Scrape downloaded file looking for phones, record to log file
{ date +'%Y-%m-%d %H:%M'; grep -c $m_phone DevicesConnected.html; grep -c $n_phone DevicesConnected.html; } | tr "\n" "\t" >> ~/logs/whoshome.log
echo "" >> ~/logs/whoshome.log

## Niks phone
#
# Check if the last two entries in the log file for the user are different from the 3rd from last and chnage staus
#
##

if [ $(tail -1 ~/logs/whoshome.log | head -1 | cut -f3) == "0" ] && [ $(tail -2 ~/logs/whoshome.log | head -1 | cut -f3) == "0" ] && [ $(tail -3 ~/logs/whoshome.log | head -1 | cut -f3) == "1" ]; then
  echo "niks gone out"
  ~/scripts/pushbullet.sh "$(date +'%Y-%m-%d %H:%M') Nik has left"
fi

if [ $(tail -1 ~/logs/whoshome.log | head -1 | cut -f3) == "1" ] && [ $(tail -2 ~/logs/whoshome.log | head -1 | cut -f3) == "1" ] && [ $(tail -3 ~/logs/whoshome.log | head -1 | cut -f3) == "0" ]; then
  echo "niks  back"
  ~/scripts/pushbullet.sh "$(date +'%Y-%m-%d %H:%M') Nik is back"
fi


## Michells  phone
#
# Check if the last two entries in the log file for the user are different from the 3rd from last and chnage staus
#
##

if [ $(tail -1 ~/logs/whoshome.log | head -1 | cut -f2) == "0" ] && [ $(tail -2 ~/logs/whoshome.log | head -1 | cut -f2) == "0" ] && [ $(tail -3 ~/logs/whoshome.log | head -1 | cut -f2) == "1" ]; then
  echo "Michelle's gone out"
  ~/scripts/pushbullet.sh "$(date +'%Y-%m-%d %H:%M') left"
fi

if [ $(tail -1 ~/logs/whoshome.log | head -1 | cut -f2) == "1" ] && [ $(tail -2 ~/logs/whoshome.log | head -1 | cut -f2) == "1" ] && [ $(tail -3 ~/logs/whoshome.log | head -1 | cut -f2) == "0" ]; then
  echo "Michelle's back"
  ~/scripts/pushbullet.sh "$(date +'%Y-%m-%d %H:%M') back"
fi

