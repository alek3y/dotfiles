#!/bin/bash

##
# Constants
#

STEP="0.2"
DEFAULT="1.0"

##
# Functions
#

function get_brightness {
	echo $(
		xrandr --verbose |
		grep -i -E 'Brightness:\s' |
		head -n 1 |
		grep -o -E '\S+\.{0,1}\S*$'
	)	
}

function set_brightness {
	monitors=$(
		xrandr --listmonitors |
		grep -vi 'Monitors:' |
		grep -o -E '\S+$'
	)

	# Set the value for every monitor
	for m in $monitors; do
		xrandr --output $m --brightness "$1"
	done
}

##
# Bar interaction
#

case $BLOCK_BUTTON in

	# Restore to default
	1)
		set_brightness "$DEFAULT"
		;;

	# Increase with scroll up
	4)
		newbr="$(get_brightness)+$STEP"
		newbr=$(echo "$newbr" | bc)
		set_brightness $newbr
		;;

	# Decrease with scroll down
	5)
		newbr="$(get_brightness)-$STEP"
		newbr=$(echo "$newbr" | bc)
		set_brightness $newbr
		;;
esac

##
# Bar feedback
#

# Print in percentage
brightness=$(get_brightness)
echo -n $(echo "($brightness*100)/1" | bc)
echo "%"
