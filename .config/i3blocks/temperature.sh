#!/bin/bash

# Get the temperature value in Celsius
temperature=$(
	sensors |
	grep -i 'tdie' |
	grep -o -E '\S+°C\s' |
	head -n 1 |
	sed -e 's/^+//' -e 's/°C\s$//'
)

# Round to nearest integer
temperature=$(echo "($temperature+0.5)/1" | bc)

# Return the value and its scale
echo "$temperature°C"
