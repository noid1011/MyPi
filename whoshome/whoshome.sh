#!/bin/bash
cd /home/pi/whoshome/

n_phone="MAC_ADDRESS"
m_phone="MAC_ADDRESS"

# Download router wifi page
curl -s -u admin:sky http://192.168.0.1/sky_lan_ip_setup_addmac.html > accessList.html

# Scrape phones to log file
{ date +'%Y-%m-%d %H:%M'; grep -c $m_phone accessList.html; grep -c $n_phone accessList.html; } | tr "\n" "\t" >> whoshome.log
echo "" >> whoshome.log

## Nik
# Returs 1 if phone present
grep -c $n_phone accessList.html

if [ $? -eq 0 ]; then
  if [ -f ./niksphone ]
    then
          echo "niks in"
    else
      echo "niks back"
      ./pushbullet.sh "Nik's Home"

          echo "niks back" > niksphone
  fi
else
    if [ -f ./niksphone ]
    then
          rm niksphone
          echo "niks left"
          ./pushbullet.sh "Nik's Left"

    else
      echo "niks away"
  fi
fi
