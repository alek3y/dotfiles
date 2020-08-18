#!/bin/bash

# Check if there's no audio running on soundcards
if [[ $(grep -R -i running /proc/asound | wc -l) == 0 ]]; then
	bash $HOME/.config/i3/lockscreen.sh
fi
