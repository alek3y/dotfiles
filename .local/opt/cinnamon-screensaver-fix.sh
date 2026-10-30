#!/bin/bash

# One of the previous versions of the Cinnamon Screensaver had a bug
# where the password would pass through into the focused application behind
# the screensaver. This script unfocus the windows during lock to fix that.

export HOME=$(getent passwd $(id -un) | cut -d ':' -f 6)
export XAUTHORITY=$HOME/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

while ! stat ${DBUS_SESSION_BUS_ADDRESS#*=} || ! stat $XAUTHORITY; do
	sleep 1
done

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" | \
	while true; do
		read state
		case "$state" in
			*true*)
				xdotool windowfocus 0	# Unfocus everything at lock
				;;
			*false*) # Unlock ops
				;;
		esac
	done
