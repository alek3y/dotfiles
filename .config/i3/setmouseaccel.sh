#!/bin/bash

# Check that the user supplied a new value
if [[ ! "$1" ]]; then
	echo -e "Usage: $0 <VALUE from -1 to 1>"
	exit 1
fi
accel="$1"

# Get device list
ids="$(xinput list --id-only)"

# Check every device
mouseid=""
for id in $ids; do
	accelprop="$(xinput list-props $id | grep 'libinput Accel Speed')"

	# Check if the device contains the acceleration property
	if [[ "$accelprop" ]]; then
		mouseid=$id
	fi
done

# Check if the mouse wasn't found
if [[ ! "$mouseid" ]]; then
	echo "Couldn't find your mouse"
	exit 1
fi

# Set the mouse speed
xinput --set-prop $mouseid 'libinput Accel Speed' $accel
