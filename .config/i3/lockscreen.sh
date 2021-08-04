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
        --inside-color=$insidecolor --insidever-color=$insidecolor --insidewrong-color=$insidecolor \
        --ring-color=$ringcolor --ringver-color=$verifyingcolor --ringwrong-color=$activecolor \
        --line-uses-inside \
        --keyhl-color=$activecolor --bshl-color=$activecolor \
        --separator-color=$activecolor \
        --verif-text="" --wrong-text="" --noinput-text="" --lock-text="" --lockfailed-text="Error" \
        --wrong-color=$ringcolor \
        --time-color=$timecolor --time-str="%H:%M" --time-size="70" --time-font="$font" \
        --date-color=$datecolor --date-str="Type password.." --date-size=20 --date-font="$font" \
        --radius=20 --ring-width=5 \
        --time-align=1 --date-align=1 \
        --ind-pos="x+50+200+32+r:y+h-65-(86/2)" --time-pos="x+50:y+h-100" --date-pos="x+50+5+2:y+h-65"
