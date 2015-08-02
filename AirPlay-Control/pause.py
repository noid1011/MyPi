import RPi.GPIO as GPIO
import time
import subprocess

GPIO.setmode(GPIO.BCM)

GPIO.setup(17, GPIO.IN)

if GPIO.input(17):
    print("Pin 2 is HIGH")
else:
    print("Pin 2 is LOW")


#initialise a previous input variable to 0 (assume button not pressed last)
prev_input = 0
while True:
  #take a reading
  input = GPIO.input(17)
  #if the last reading was low and this one high, print
  if ((not prev_input) and input):
    print("Button pressed")
    subprocess.call(['./pause.sh'])
    0
