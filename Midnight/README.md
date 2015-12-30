#### Midnight script
Going to shut some things down

Get ADP

```
wget https://dl.dropboxusercontent.com/u/3048074/adb
chmod +x adb
sudo mv adb /bin/
```

Download bash script

```
cd ~/scripts
wget https://raw.githubusercontent.com/noid1011/MyPi/master/Midnight/midnight.sh
chmod +x midnight.sh
```

add script to crontab
```
crontab -e
```
add:

`0 0  * * * ~/scripts/midnight.sh`
