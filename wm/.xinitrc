#!/bin/sh

# Configuration
readonly KEYMAP=it
readonly RESOLUTION=(1440 960 60)
readonly WALLPAPER=~/.local/opt/wm/wallpaper.*

# Keyboard
setxkbmap $KEYMAP

# Monitor
monitor=$(xrandr | grep -ioP '\S*\s+(?=connected primary)')
modeline=$(cvt ${RESOLUTION[@]} | grep -ioP '(?<=Modeline).*$')
modename=$(echo $modeline | cut -d " " -f 1)

if [[ ${#RESOLUTION[@]} -gt 0 ]]; then
	xrandr --newmode $modeline
	xrandr --addmode $monitor $modename
	xrandr --output $monitor --mode $modename
fi

# Wallpaper
feh --bg-fill $WALLPAPER

# Window manager
exec dwm
