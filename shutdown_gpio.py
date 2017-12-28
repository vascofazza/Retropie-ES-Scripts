import RPi.GPIO as GPIO
import os
import sys
import time


powerGPIO = 27
GPIO.setmode(GPIO.BCM)
GPIO.setup(powerGPIO, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while True:
  time.sleep(1)
  if GPIO.input(powerGPIO):
    os.system("sudo poweroff")
