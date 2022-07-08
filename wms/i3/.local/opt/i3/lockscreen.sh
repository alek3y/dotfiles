#!/bin/bash

readonly BACKGROUND_MISSING_WALLPAPER="#000000"
readonly COLOR_RING_INSIDE="#ffffff00"
readonly PROMPT="Type password..."
readonly INDICATOR_POSITION="x+50+200+45+r:y+h-65-(86/2)"
readonly TIME_POSITION="x+50:y+h-100"
readonly DATE_POSITION="x+50+5+2:y+h-65"

# Source the variables from a configuration file
source "$@"

# Prevent locking when it's already running
running_processes=$(pgrep -xc i3lock)
if [[ $running_processes -ne 0 ]]; then
	exit 1
fi

i3lock \
	--screen 1 \
	--color=$BACKGROUND_MISSING_WALLPAPER \
	--pointer default --force-clock \
	--image="$WALLPAPER" --centered --ignore-empty-password \
	--inside-color=$COLOR_RING_INSIDE --insidever-color=$COLOR_RING_INSIDE --insidewrong-color=$COLOR_RING_INSIDE \
	--ring-color=$COLOR_RING --ringver-color=$COLOR_VERIFY --ringwrong-color=$COLOR_ACTIVE \
	--line-uses-inside \
	--keyhl-color=$COLOR_ACTIVE --bshl-color=$COLOR_ACTIVE --separator-color=$COLOR_ACTIVE \
	--verif-text="" --wrong-text="" --noinput-text="" --lock-text="" --lockfailed-text="Error" \
	--wrong-color=$COLOR_RING \
	--time-color=$COLOR_TIME --time-str="%H:%M" --time-size="70" --time-font="$FONT" \
	--date-color=$COLOR_PROMPT --date-str="$PROMPT" --date-size=20 --date-font="$FONT" \
	--radius=20 --ring-width=5 --time-align=1 --date-align=1 \
	--ind-pos="$INDICATOR_POSITION" --time-pos="$TIME_POSITION" --date-pos="$DATE_POSITION"
