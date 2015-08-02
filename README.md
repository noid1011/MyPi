# MyPi

### raspi-config

To expand filesystem, change user password and set timezone (in internationalisation options).

`sudo raspi-config`

`sudo reboot`

### Download wifi settings

```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/interfaces
sudo cp interfaces /etc/network/
sudo rm interfaces
```
`sudo nano /etc/wpa_supplicant/wpa_supplicant.conf`

ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
ssid="--------"
proto=RSN
key_mgmt=WPA-PSK
pairwise=CCMP TKIP
group=CCMP TKIP
psk="--------"
}

####Update Pi 

`sudo apt-get update && sudo apt-get --force-yes upgrade`
