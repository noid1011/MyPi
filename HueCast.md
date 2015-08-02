#Installing HueCast

####Install Phue

Phue: Full featured Python library to control the Philips Hue lighting system.

```
sudo apt-get install python-pip
sudo pip install phue
```
Press sync on Hue Hub and get key

`sudo python /usr/local/lib/python2.7/dist-packages/phue.py --host 192.168.0.55`

Test it
```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/random_colors.py 
sudo python random_colors.py
```
