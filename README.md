# MyPi

### raspi-config

To expand filesystem, change user password and set timezone (in internationalisation options).

`sudo raspi-config`

`sudo reboot`

#### Download wifi settings

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

####Setting up HDD

Get UUIDs

`sudo blkid`

`sudo mkdir /media/music`

Open fstab file

`sudo nano /etc/fstab`

Add the following configuration

`UUID=323A59483A5909ED /media/music auto uid=pi,gid=pi,noatime 0 0`

NTFS drivers
```
sudo apt-get install ntfs-3g
sudo mount -a
sudo reboot
```
####Install forked-daapd

```
echo "deb http://www.gyfgafguf.dk/raspbian wheezy-backports/armhf/" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install forked-daapd
sudo nano /etc/forked-daapd.conf
```
```
sudo /etc/init.d/forked-daapd restart
tail /var/log/forked-daapd.log
```

Pair remote
`sudo nano /media/music/noid.remote`


