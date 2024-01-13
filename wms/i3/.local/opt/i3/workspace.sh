#!/bin/bash

IFS=$'\n'

# See https://old.reddit.com/r/swaywm/comments/v32t6q/how_do_i_get_the_currently_focused_monitor/iaw1q4q/
focused=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')

move=0
for arg in $@; do
	if [[ $arg == '-m' ]]; then
		move=1
		continue
	fi

	monitor=$(echo "$arg" | cut -d= -f1)
	workspace=$(echo "$arg" | cut -d= -f2)

	if [[ $monitor == $focused ]]; then
		if [[ $move -eq 0 ]]; then
			i3-msg workspace "$workspace"
		else
			i3-msg move container to workspace "$workspace"
		fi
		break
	fi
done
