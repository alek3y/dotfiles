#!/bin/bash

level=$(acpi -b | grep -ioP '[0-9]+%')

if [[ -z $level ]]; then
	echo " N/A"
else
	echo " $level"
fi
