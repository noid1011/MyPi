#!/bin/bash

# shutdown fire tv
#adb kill-server
#adb start-server
#adb connect 192.168.0.21
#adb shell input keyevent 26
#adb kill-server

#trim log files
echo "`tail -2000 ~/logs/whoshome.log`" > ~/logs/whoshome.log
