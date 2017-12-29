#
# This scrit was designed for Raspberry with Retropie/EmulationStation.
# Author: Federico Scozzafava
# 
# THIS HEADER MUST REMAIN WITH THIS FILE AT ALL TIMES
#
# This firmware is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This firmware is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this repo. If not, see <http://www.gnu.org/licenses/>.
#

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
