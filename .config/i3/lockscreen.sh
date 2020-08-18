#!/bin/bash

##
# Colors
#

background="$HOME/Pictures/wallpaper.png"
backgroundcolor="000000ff"
ringcolor="ffffffff"
insidecolor="ffffff00"
activecolor="e53935ff"
verifyingcolor="ffffffaa"
timecolor="ffffffff"
datecolor="eeeeeeff"
font="monospace"

##
# Layout
#

i3lock \
        --screen 1 \
        --color=$backgroundcolor \
        --pointer default \
        --force-clock \
        --image $background --centered \
        --ignore-empty-password \
        --insidecolor=$insidecolor --insidevercolor=$insidecolor --insidewrongcolor=$insidecolor \
        --ringcolor=$ringcolor --ringvercolor=$verifyingcolor --ringwrongcolor=$activecolor \
        --line-uses-inside \
        --keyhlcolor=$activecolor --bshlcolor=$activecolor \
        --separatorcolor=$activecolor \
        --veriftext="" --wrongtext="" --noinputtext="" --locktext="" --lockfailedtext="Error" \
        --wrongcolor=$ringcolor \
        --timecolor=$timecolor --timestr="%H:%M" --timesize="70" --time-font=$font \
        --datecolor=$datecolor --datestr="Type password.." --datesize=20 --date-font=$font \
        --radius=20 --ring-width=5 \
        --time-align=1 --date-align=1 \
        --indpos="x+50+200+32+r:y+h-65-(86/2)" --timepos="x+50:y+h-100" --datepos="x+50+5+2:y+h-65"
