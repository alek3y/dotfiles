#!/bin/bash

# Print percentage from `acpi`
echo -n $(
	acpi -b 2>/dev/null |
	grep -o -E '\S+%'
)

# Get the battery status
status=$(
	acpi -b 2>/dev/null |
	grep -o -E ':\s.+,' |
	cut -d "," -f 1 |
	cut -d " " -f 2
)

# Change it to lower case
status=${status,,}

# Show a bolt if it's charging
if [[ "$status" == "charging" || "$status" == "unknown" ]]; then
	echo " ⚡"
else
	echo
fi
