#!/bin/bash

##
# Constants
#

STEP="5"
DEFAULT="15"

##
# Bar interaction
#

case $BLOCK_BUTTON in

	# Restore to default with left click
	1)
		xbacklight -set $DEFAULT
		;;

	# Set to maximum with right click
	3)
		xbacklight -set 100
		;;

	# Increase with scroll up
	4)
		xbacklight -inc $STEP
		;;

	# Decrease with scroll down
	5)
		xbacklight -dec $STEP
		;;
esac

##
# Bar feedback
#

brightness=$(xbacklight -get)
brightness=$(echo "$brightness/1" | bc)
echo "$brightness%"
