#AirPlay Control

```
cd ~
sudo mkdir remote
cd remote
wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/watcher.py
wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/pause.sh
wget https://raw.githubusercontent.com/noid1011/MyPi/master/AirPlay-Control/pause.py
sudo chmod +x pause.sh
sudo ./pause.sh
sudo python pause.py
```

Add wathcer to /etc/rc.local

```
sudo nano /etc/rc.local
```
Add
```
python /home/pi/remote/watcher.py
```
