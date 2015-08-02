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

####Install forecastio

```
cd ~
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo pip install python-forecastio
```
####Install HueCast
Some dependancies
```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
sudo pip install cryptography 
sudo pip install requests[security]
```
get my modfied script and add API key
```
wget https://raw.githubusercontent.com/noid1011/MyPi/master/huecast.py
sudo nano huecast.py
```
`sudo python huecast.py`

Add huecast to cron

`sudo crontab -e`

`*/10 * * * * python /home/pi/huecast.py`
