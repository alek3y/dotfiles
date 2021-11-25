#!/bin/bash

source util.sh

readonly CHARGING=""
readonly LEVELS=("" "" "" "" "" "" "" "" "" "")
readonly MISSING=""

level=$(acpi -b | grep -ioP '[0-9]+(?=%)')

if [[ -z $level ]]; then
	echo "$MISSING N/A"
else
	icon_index=$(map $level 0 100 0 $((${#LEVELS[@]} - 1)))
	echo "${LEVELS[$icon_index]} $level%"
fi
