#!/bin/bash

readonly SEPARATOR="⎪"
readonly REFRESH=2		# TODO: Add to .xinitrc

# 1 is reserved as separator
declare -rA BLOCKS=(
	["",2]="volume.sh"		# TODO: Move icons to .sh files
	["",3]="battery.sh"
)

readonly PID_FILE=$(dirname "$(mktemp -u)")/wm_status.pid

function to_byte {
	printf "\x$(printf '%x' $1)"
}

listen=0
update=0
block=
button=

args=($@)
i=0
while [[ $i -lt ${#args[@]} ]]; do
	arg=${args[$i]}

	case $arg in
		-*l*|--listener)
			listen=1
			;;&
		-*u|--update)
			update=1
			i=$(($i + 1))
			params="${args[$i]},"
			block=$(echo $params | cut -d',' -f1)
			button=$(echo $params | cut -d',' -f2)
			;;
	esac

	i=$(($i + 1))
done

script_location=$(dirname "$BASH_SOURCE")

if [[ $update -eq 1 ]]; then

	# TODO: Simplify this?
	for key in ${!BLOCKS[@]}; do
		key_id=$(echo $key | cut -d "," -f 2)

		if [[ $key_id -eq $block ]]; then
			bash "$script_location/${BLOCKS[$key]}" "$button"
			break
		fi
	done

	kill -s SIGUSR1 $(cat "$PID_FILE") 2>/dev/null
fi

if [[ $listen -eq 1 ]]; then
	if [[ -f "$PID_FILE" ]]; then
		running=$(pgrep -F "$PID_FILE")
		[[ ! -z $running ]] && kill $running
	fi
	echo "$$" > "$PID_FILE"

	trap 'continue' SIGUSR1
	while true; do
		status=
		for key in ${!BLOCKS[@]}; do
			key_icon=$(echo $key | cut -d "," -f 1)
			key_id=$(echo $key | cut -d "," -f 2)

			value=$(bash "$script_location/${BLOCKS[$key]}")

			status+=$(to_byte $key_id)
			status+=$(printf '%s %s\x1 %s ' "$key_icon" "$value" "$SEPARATOR")		# TODO: Fix this ugly mess
		done

		xsetroot -name " $status"		# TODO: Fix ugly missing space

		sleep $REFRESH &
		wait $!
	done
fi
