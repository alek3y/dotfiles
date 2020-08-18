#!/bin/bash

# Count how many processes are running sound
soundprocs=$(grep -R -i running /proc/asound | wc -l)

# Count how many i3lock processes are running
lockprocs=$(ps axH | grep -vi grep | grep -i i3lock | wc -l)

# Check that no processes are using the audio and
# that the lockscreen isn't already running
if [[ $soundprocs == 0 && $lockprocs == 0 ]]; then
	bash $HOME/.config/i3/lockscreen.sh
fi
