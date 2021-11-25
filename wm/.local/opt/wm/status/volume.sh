#!/bin/bash

readonly DEFAULT=30
readonly STEP=5
readonly LEVELS=("墳" "" "")
readonly MUTED="婢"

sink=$(pamixer --get-default-sink)
volume=$(pamixer --get-volume)

button=$1
case $button in
	1)
		pamixer -t
		;;
	2)
		pamixer --set-volume $DEFAULT
		;;
	3)
		pavucontrol
		;;
	4)
		pamixer -d $STEP
		;;
	5)
		pamixer -i $STEP
		;;
	*)
		if pamixer --get-mute >/dev/null; then
			icon=$MUTED
		else
			icon=$LEVELS
		fi

		echo "$icon $volume%"
		;;
esac
