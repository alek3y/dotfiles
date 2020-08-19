#!/bin/bash

##
# Constants
#

# Setting the default mixer as "PulseAudio", might
# also be "jackplug" for Jack/Jack2 or "default"
# for ALSA
MIXER="pulse"

# Setting Master as default control, check yours
# with `amixer -D pulse`
SCONTROL="Master"

##
# Functions
#

# Extract the value inside square parenthesis
# (through piping)
function extract_value {
	read text
	echo $text |
		sed -e 's/^\[//' -e 's/\]$//'
}

# Get the text to display on the bar
function get_volume {
	info=$(
		amixer -D $MIXER sget $SCONTROL |
		grep "%" |
		head -n 1
	)

	# Get the current volume of the device
	volume=$(
		echo $info |
		grep -o '\[.*%\]' |
		extract_value
	)

	# Get the status of the device, either on or off (mute)
	state=$(
		echo $info |
		grep -o -E '\[.{2}(f|)\]' |
		extract_value
	)

	# Return the text to display
	if [[ "$state" == "off" ]]; then
		echo "Muted"
	else
		echo $volume
	fi
}

##
# Bar interactions
#

case $BLOCK_BUTTON in

	# Toggle mute with left click
	1)
		amixer -q -D $MIXER sset $SCONTROL toggle
		;;

	# Open pavucontrol with right click
	3)
		i3-msg exec pavucontrol >/dev/null
		;;

	# Increase with scroll up
	4)
		amixer -q -D $MIXER sset $SCONTROL 5%+ unmute
		;;

	# Decrease with scroll down
	5)
		amixer -q -D $MIXER sset $SCONTROL 5%- unmute
		;;
esac

##
# Bar feedback
#

# Return the volume
get_volume
