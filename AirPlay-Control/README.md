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

Add wathcer to /etc/rc.local

```
sudo nano /etc/rc.local
```
Add
```
python /home/pi/remote/watcher.py
```
