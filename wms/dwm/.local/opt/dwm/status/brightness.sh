#!/bin/bash

readonly DEFAULT=30
readonly STEP=5		# See ~/.xbindkeysrc
readonly ICON=""

brightness=$(xbacklight | grep -ioP '^[0-9]+')

if [[ -z $brightness ]]; then
	echo "$ICON N/A"
	exit 1
fi

button=$1
case $button in

	# Middle click
	2)
		xbacklight -set $DEFAULT
		;;

	# Scroll up (natural scrolling)
	4)
		xbacklight -time 0 -steps 1 -dec $STEP
		;;

	# Scroll down (natural scrolling)
	5)
		xbacklight -time 0 -steps 1 -inc $STEP
		;;

	*)
		echo "$ICON $brightness%"
		;;
esac
