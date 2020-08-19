#!/bin/bash

##
# Colors
#

wallpaper="$HOME/Pictures/lockscreen.png"
backgroundcolor="000000ff"		# Background color when no image is loaded
ringcolor="f2f2f2ff"
insidecolor="ffffff00"		# Make the inside of the ring transparent
activecolor="b74c4aff"		# Color of the highlight when typing
verifyingcolor="f2f2f2aa"		# Ring color when checking for the password
timecolor="f2f2f2ff"
datecolor="f2f2f2ff"		# Color of the greeting
font="DejaVu Sans Mono"

##
# Layout
#

i3lock \
        --screen 1 \
        --color=$backgroundcolor \
        --pointer default \
        --force-clock \
        --image="$wallpaper" --centered \
        --ignore-empty-password \
        --insidecolor=$insidecolor --insidevercolor=$insidecolor --insidewrongcolor=$insidecolor \
        --ringcolor=$ringcolor --ringvercolor=$verifyingcolor --ringwrongcolor=$activecolor \
        --line-uses-inside \
        --keyhlcolor=$activecolor --bshlcolor=$activecolor \
        --separatorcolor=$activecolor \
        --veriftext="" --wrongtext="" --noinputtext="" --locktext="" --lockfailedtext="Error" \
        --wrongcolor=$ringcolor \
        --timecolor=$timecolor --timestr="%H:%M" --timesize="70" --time-font="$font" \
        --datecolor=$datecolor --datestr="Type password.." --datesize=20 --date-font="$font" \
        --radius=20 --ring-width=5 \
        --time-align=1 --date-align=1 \
        --indpos="x+50+200+32+r:y+h-65-(86/2)" --timepos="x+50:y+h-100" --datepos="x+50+5+2:y+h-65"
