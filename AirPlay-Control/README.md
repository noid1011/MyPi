#AirPlay Control

```
cd ~
sudo mkdir remote
cd remote
sudo wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/watcher.py
sudo wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/pause.sh
sudo wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/pause.py
sudo chmod +x pause.sh
sudo ./pause.sh
sudo python pause.py
```

```
sudo wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/airremote
sudo mv airremote /etc/init.d/
sudo chmod 755 /etc/init.d/airremote
sudo update-rc.d airremote defaults
sudo reboot
```
