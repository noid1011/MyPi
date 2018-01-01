# MyPi
###Setup WiFi

Save wpa_supplicant.conf in root directory

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=GB

network={
    ssid="«your_SSID»"
    psk="«your_PSK»"
    key_mgmt=WPA-PSK
}
```


###Update Pi

 ```
sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get -y --force-yes upgrade```

sudo apt-get -y install screen sshpass wakeonlan
```


###Setup ssh key login

http://raspi.tv/2012/how-to-set-up-keys-and-disable-password-login-for-ssh-on-your-raspberry-pi

```
cd ~
mkdir .ssh
cd .ssh
echo '[[SHA KEY]]' > authorized_keys
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys
```
`sudo nano /etc/ssh/sshd_config` // #PasswordAuthentication yes -> PasswordAuthentication no
                                 // Port 22 -> Port 3322
`sudo /etc/init.d/ssh restart`


### raspi-config

To expand filesystem, change user password and set timezone (in internationalisation options).

`sudo raspi-config`

`sudo reboot`


####Setting up HDD


NTFS drivers
```
sudo apt-get install ntfs-3g
