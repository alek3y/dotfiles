#!/bin/bash

source util.sh

readonly CHARGING=""
readonly LEVELS=("" "" "" "" "" "" "" "" "" "")
readonly MISSING=""

level=$(acpi -b | grep -ioP '[0-9]+(?=%)')
status=$(acpi -b | grep -ioP '((dis)?charging|full)' | tr '[:upper:]' '[:lower:]')

if [[ -z $level || -z $status ]]; then
	echo "$MISSING N/A"
	exit 1
fi

if [[ $status == "discharging" ]]; then
	icon_index=$(map $level 0 100 0 $((${#LEVELS[@]} - 1)))
	echo "${LEVELS[$icon_index]} $level%"
else
	echo "$CHARGING $level%"
fi
