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
```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/wpa_supplicant.conf
sudo cp wpa_supplicant.conf /etc/wpa_supplicant/
sudo rm wpa_supplicant.conf
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```


####Update Pi 

`sudo apt-get update && sudo apt-get --force-yes upgrade`
