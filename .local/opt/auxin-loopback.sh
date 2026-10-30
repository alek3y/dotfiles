#!/bin/bash

# Find this with `pactl list sources`
readonly OUTSIDE_SOURCE="alsa_input.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.mono-fallback"
readonly LATENCY_MSEC=5

printf "Starting microphone loopback (press CTRL-C to stop it)\n"
if which pw-loopback &>/dev/null; then
	pw-loopback -l $LATENCY_MSEC -C $OUTSIDE_SOURCE
else
	pactl load-module module-loopback latency_msec=$LATENCY_MSEC source=$OUTSIDE_SOURCE
	trap 'pactl unload-module module-loopback' SIGINT
	sleep infinity
fi
