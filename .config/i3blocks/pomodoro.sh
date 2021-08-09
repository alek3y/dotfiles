#!/bin/bash

readonly TIME_INCREASE=300
readonly POMODORO_FILENAME="pomodoro"

tmpdir=$(dirname $(mktemp -u))
pomodoro_filepath="$tmpdir/$POMODORO_FILENAME"

if [[ ! -f "$pomodoro_filepath" ]]; then
	printf "0 0" > "$pomodoro_filepath"
	exit 1
fi

status=($(cat "$pomodoro_filepath"))
seconds=${status[0]}
running=${status[1]}

case $BLOCK_BUTTON in

	# Pause and resume with left click
	1)
		if [[ $running -eq 0 && $seconds -gt 0 ]]; then
			running=1
		else
			running=0
		fi
		;;

	# Reset timer with right click
	3)
		seconds=0
		running=0
		;;

	# Increase time with scroll up
	4)
		seconds=$(($seconds + $TIME_INCREASE))
		;;

	# Decrease time with scroll up
	5)
		seconds=$(($seconds - $TIME_INCREASE))
		;;

	*)
		if [[ $running -eq 1 ]]; then
			seconds=$(($seconds - 1))
		fi
esac

# Ensure seconds stay positive
if [[ $seconds -lt 0 ]]; then
	seconds=0
	running=0
fi
printf "%s %s" $seconds $running > "$pomodoro_filepath"

format="%M:%S"
if [[ $seconds -ge 3600 ]]; then
	format="%H:$format"
fi

date -ud @$seconds +$format
