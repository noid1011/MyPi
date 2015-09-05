#!/bin/bash


adb kill-server
adb start-server
adb connect 192.168.0.21
adb shell input keyevent 26
adb kill-server
