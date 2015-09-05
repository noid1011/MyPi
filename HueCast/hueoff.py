#!/usr/bin/python
from phue import Bridge
b = Bridge('192.168.0.55')

b.set_light(1,'on':False) 
b.set_light(2,'on':False)
