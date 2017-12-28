#!/bin/bash
#######
#
# Automatically detects HDMI cable attach event and thus mirrors the main screen and audio to it
# Author: Federico Scozzafava
#
######
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
