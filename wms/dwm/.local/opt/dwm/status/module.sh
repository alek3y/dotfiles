#!/bin/bash

readonly SEPARATOR="⎪"
readonly REFRESH=1.5

readonly BLOCKS=(
	"brightness.sh"
	"volume.sh"
	"battery.sh"
	"date.sh"
)

readonly STATUSCMDS_START_ID=2		# See dwm/config.def.h
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
cd $script_location

if [[ $update -eq 1 ]]; then
	if [[ ! -z $block ]]; then
		bash "${BLOCKS[$block]}" "$button"
	fi

	kill -s SIGUSR1 $(cat "$PID_FILE") 2>/dev/null
fi

if [[ $listen -eq 1 ]]; then
	if [[ -f "$PID_FILE" ]]; then
		running=$(pgrep -F "$PID_FILE")
		[[ ! -z $running ]] && kill $running
	fi
	echo "$$" > "$PID_FILE"

	block_last_idx=$((${#BLOCKS[@]} - 1))

	trap '[[ $loading_status -eq 0 ]] && continue' SIGUSR1
	while true; do
		status=
		loading_status=1
		for i in $(seq 0 $block_last_idx); do
			statuscmd_id=$(($i + $STATUSCMDS_START_ID))
			status+=$(to_byte $statuscmd_id)

			output=$(bash "${BLOCKS[$i]}" 2>/dev/null)
			status+=$(printf '%s' "$output")

			status+=$(to_byte 1)
			if [[ $i -lt $block_last_idx ]]; then
				status+=$(printf ' %s ' "$SEPARATOR")
			fi
		done
		loading_status=0

		xsetroot -name " $status " 2>/dev/null
		if [[ $? -ne 0 ]]; then
			break
		fi

		sleep $REFRESH &
		wait $!
	done
fi
