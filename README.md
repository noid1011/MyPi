# MyPi

## raspi-config

To expand filesystem, change user password and set timezone (in internationalisation options).

`sudo raspi-config`

`sudo reboot`

## Download wifi settings

```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/interfaces
sudo cp interfaces /etc/network/
sudo rm interfaces
```
