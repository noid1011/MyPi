#### Midnight script
Going to shut some things down

#ADP

```
wget https://dl.dropboxusercontent.com/u/3048074/adb
chmod +x adb
mv adb /bin/
```

```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/Midnight/midnight.sh
chmod +x midnight.sh
sudo crontab -e
```
add:

`0 0  * * * bash /home/pi/midnight.sh`
