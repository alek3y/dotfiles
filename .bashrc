#  _           _
# | |_ ___ ___| |_ ___ ___
# | . | .'|_ -|   |  _|  _|
# |___|__,|___|_|_|_| |___|
#
# This is ale's ~/.bashrc

##
# Environment variables
#

export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL="ignoreboth"
export EDITOR="kak"
#export LS_COLORS+=":ow=01;34"		# Fix ugly folders color on NTFS drives

##
# Terminal options
#

source /etc/profile.d/vte.sh		# Use last tab working directory for new tabs
shopt -s histappend		# Append to history file
shopt -s checkwinsize		# Continuously check for window size

##
# PS1
#

BOLD="\[\033[1m\]"
RESET="\[\033[0m\]"
FRG_DARK="\[\033[38;5;242m\]"
FRG_USER="\[\033[38;5;12m\]"
FRG_PATH="\[\033[38;5;13m\]"		# Or 103m
PS1="$BOLD$FRG_DARK[$FRG_USER \u@\h $FRG_DARK][$FRG_PATH \w $FRG_DARK] »$RESET "

##
# Greetings
#

#cmdotd="$(locate cmdotd.py | awk '/.+\.py$/')"		# Might have to `updatedb` or install `mlocate`
if [[ "$EUID" != 0 && ! "$ASCIINEMA_REC" && ! "$TMUX" && "$cmdotd" ]]; then
	python3 $cmdotd
fi

##
# Aliases
#

alias sudo="sudo "		# Allows aliases with sudo (https://unix.stackexchange.com/a/349290)
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias dd="dd status=progress"
alias bc="bc -lq"
alias trash="gio trash"
alias feh="feh --scale-down --auto-zoom"
alias pkexec="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY"
alias cal="cal -m"

##
# Functions
#

function arec {
	DEVID="$(pacmd list-sinks | awk '/\*/ { print $NF }')"
	parec -d $DEVID | lame -r -V0 - $1
}
function now {
	date +%s%N | cut -b -13
}
function screenshot {
	file="$(mktemp -u).png"
	gnome-screenshot -a -f $file
	xclip -selection clipboard -target image/png $file
	#rm $file
}
function man {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	command man "$@"
}
function detach {
	command "$@" >/dev/null 2>&1 &
	disown
}
function vyt {
	url=$(echo "$1" | sed 's/&list=.*//g')		# Remove playlist link
	stream=($(youtube-dl -g "$url"))
	detach vlc "${stream[0]}" --input-slave "${stream[1]}"
}
