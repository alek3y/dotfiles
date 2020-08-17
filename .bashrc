#  _           _           
# | |_ ___ ___| |_ ___ ___ 
# | . | .'|_ -|   |  _|  _|
# |___|__,|___|_|_|_| |___|
#
# This is ale's ~/.bashrc
# https://stackoverflow.com/a/6366607

# Bash variables
HISTSIZE=-1
HISTFILESIZE=-1

# Terminal options
shopt -s histappend		# Append to history file
shopt -s checkwinsize		# Continuously check for window size

# Setup the PS1
BOLD="\[\033[1m\]"
RESET="\[\033[0m\]"
BCK_RED="\[\033[48;2;179;27;27m\]"
BCK_GREEN="\[\033[48;2;0;140;124m\]"
BCK_BLUE="\[\033[48;2;86;157;182m\]"
FRG_RED="\[\033[38;2;179;27;27m\]"
FRG_GREEN="\[\033[38;2;0;140;124m\]"
FRG_BLUE="\[\033[38;2;86;157;182m\]"
FRG_WHITE="\[\033[38;2;230;230;230m\]"

if [[ "$EUID" != 0 ]]; then
	PS1="$FRG_WHITE$BOLD$BCK_GREEN \u@\h $RESET$FRG_GREEN$BCK_BLUE$RESET$FRG_WHITE$BOLD$BCK_BLUE \w $RESET$FRG_BLUE$RESET "
else
	PS1="$FRG_WHITE$BOLD$BCK_RED \u@\h $RESET$FRG_RED$BCK_BLUE$RESET$FRG_WHITE$BOLD$BCK_BLUE \w $RESET$FRG_BLUE$RESET "
fi

# Run cmdotd with some exceptions
cmdotd="$(locate cmdotd.py | awk '/.+\.py$/')"		# Might have to `updatedb` or install `mlocate`
if [[ "$EUID" != 0 && ! "$ASCIINEMA_REC" && ! "$TMUX" && "$cmdotd" ]]; then
	python3 $cmdotd
fi

# Aliases
alias sudo='sudo '		# Allows the use of aliases with sudo (https://unix.stackexchange.com/a/349290)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pkexec='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
alias dd='dd status=progress'
alias trash='gio trash'

# Functions
function arec {
	DEVID="$(pacmd list-sinks | awk '/\*/ { print $NF }')"
	parec -d $DEVID | lame -r -V0 - $1
}
function screenshot {
	file="$(mktemp -u).png"
	gnome-screenshot -a -f $file
	xclip -selection clipboard -target image/png $file
	#rm $file
}
function brightness {
	monitors=$(xrandr --listmonitors | awk '/\S+$/ && NR>1 { print $NF }')
	if [[ -z "$1" && -z "$2" ]]; then
		echo -e "Usage: brightness < VALUE >"
		echo -e "Night light causes issues."
	else
		for m in $monitors; do
			xrandr --output $m --brightness $1
		done
	fi
}