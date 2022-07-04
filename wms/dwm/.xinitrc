#!/bin/sh

# Configuration
readonly KEYMAP=it
readonly RESOLUTION=(1440 960 60)
readonly WALLPAPER=~/.local/opt/dwm/wallpaper.*

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

# Touchpad
touchpad=$(xinput list --short | \
	grep -iP '(?<=touchpad)\s*id=' | \
	grep -ioP '(?<=id=)[0-9]+')

xinput set-prop $touchpad "libinput Natural Scrolling Enabled" 1
xinput set-prop $touchpad "libinput Tapping Enabled" 1

# Multimedia keys
xbindkeys --poll-rc

# Wallpaper
feh --bg-fill $WALLPAPER

# Statusbar handler
~/.local/opt/dwm/status/module.sh -l &

# Network Manager
nm-applet &

# Window manager
exec dwm
