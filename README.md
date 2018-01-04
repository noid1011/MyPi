# Pi Setup

## SD Card Setup 

### Enable SSH

place blank file named SSH in root to enable SSH

### Setup WiFi

Save wpa_supplicant.conf in root directory
https://raspberrypi.stackexchange.com/questions/10251/prepare-sd-card-for-wifi-on-headless-pi

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
## First Run

### Update Pi

 ```
sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get -y --force-yes upgrade

sudo apt-get -y install screen
```


### Setup ssh key login

http://raspi.tv/2012/how-to-set-up-keys-and-disable-password-login-for-ssh-on-your-raspberry-pi

```
cd ~
mkdir .ssh
cd .ssh
echo «your_public_key» > authorized_keys
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


### Setting up HDD


NTFS drivers
```
sudo apt-get install ntfs-3g
```

### Installing Mosquito
```
sudo apt install -y mosquitto mosquitto-clients
```
To make Mosquitto auto start on boot up enter:
```
sudo systemctl enable mosquitto.service
```

### Installing Node.js
```
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt install nodejs
```

### Installing Smartthings Bridge

https://github.com/stjohnjohnson/smartthings-mqtt-bridge

```
sudo npm install -g smartthings-mqtt-bridge

```

edit ~/config.yml

### Install PM2

```
sudo npm install -g pm2
pm2 startup
```
run displayed command
sudo env PATH=$PATH:/usr/bin /usr/lib/nod...........
```
pm2 start smartthings-mqtt-bridge
pm2 save
sudo reboot
pm2 list
```

### Whos home script
My router lists connected devices on its web page so we can download the page and search for known devices
```
#!/bin/bash
if curl -s 192.168.0.1 | grep -c MichellesiPhone; then
  mosquitto_pub -r -t smartthings/iphone/presence -m "present"
else
  mosquitto_pub -r -t smartthings/iphone/presence -m "not present"
fi
```

then make the script executable and run from crontab

