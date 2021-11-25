#!/bin/bash

readonly DEFAULT=30
readonly STEP=5
readonly LEVELS=("墳" "" "")
readonly MUTED="婢"

sink=$(pamixer --get-default-sink)
volume=$(pamixer --get-volume)

button=$1
case $button in

	# Left click
	1)
		pamixer -t
		;;

	# Middle click
	2)
		pamixer --set-volume $DEFAULT
		;;

	# Right click
	3)
		pavucontrol
		;;

	# Scroll up (natural scrolling)
	4)
		pamixer -d $STEP
		;;

	# Scroll down (natural scrolling)
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
