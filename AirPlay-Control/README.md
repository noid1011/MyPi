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

Find playlist id

```
sqlite3 /var/cache/forked-daapd/songs3.db
select id,title from playlists;
.quit
```

How to start playlist
```
curl "http://localhost:3689/login?pairing-guid=0x1&request-session-id=50" > /dev/null 2>&1
curl "http://localhost:3689/ctrl-int/1/playspec?database-spec='dmap.persistentid:0x1'&container-spec='dmap.persistentid:[PLAYLISTID_HEX]'&container-item-spec='dmap.containeritemid:[ITEMID_HEX]'&session-id=50" > /dev/null 2>&1
curl "http://localhost:3689/logout?session-id=50" > /dev/null 2>&1
```
