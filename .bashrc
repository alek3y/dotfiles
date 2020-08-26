#  _           _
# | |_ ___ ___| |_ ___ ___
# | . | .'|_ -|   |  _|  _|
# |___|__,|___|_|_|_| |___|
#
# This is ale's ~/.bashrc

##
# Bash variables
#

HISTSIZE=-1
HISTFILESIZE=-1

##
# Terminal options
#

shopt -s histappend		# Append to history file
shopt -s checkwinsize		# Continuously check for window size

##
# PS1
#

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

##
# Greetings
#

cmdotd="$(locate cmdotd.py | awk '/.+\.py$/')"		# Might have to `updatedb` or install `mlocate`
if [[ "$EUID" != 0 && ! "$ASCIINEMA_REC" && ! "$TMUX" && "$cmdotd" ]]; then
	python3 $cmdotd
fi

##
# Aliases
#

alias sudo='sudo '		# Allows aliases with sudo (https://unix.stackexchange.com/a/349290)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dd='dd status=progress'
alias trash='gio trash'
alias feh='feh --scale-down --auto-zoom'
alias pkexec='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'

##
# Functions
#

function screenshot {
	file="$(mktemp -u).png"
	gnome-screenshot -a -f $file
	xclip -selection clipboard -target image/png $file
	#rm $file
}
