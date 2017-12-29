#!/bin/bash

#
# Automatically detects HDMI cable attach event and thus mirrors the main screen and audio to it.
# This scrit was designed for cloning DPI screen to HDMI on a Raspberry with Retropie/EmulationStation.
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

pid=-1
function hdmi_handler {
	event=$1
	echo $event
	if echo $event | grep -Fq "attached" ; then # attached
		echo "ATTACHED"
		tvservice -p #power on
		amixer cset numid=3 2 #audio output to HDMI
		/home/pi/gertCloner/cloner.bin -fps 60&
		pid=$!
	fi
	if echo $event | grep -Fq "unplugged" ; then # attached
		echo "UNPLUGGED"
		tvservice -o #power off
		amixer cset numid=3 1?#audio output to jack
		kill $pid
	fi
}

#hdmi_handler "DPI"

tvservice -M 2>&1 | while read event ; do
	hdmi_handler "$event"
done
