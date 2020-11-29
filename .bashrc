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
HISTCONTROL=ignoreboth
export EDITOR=nano

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
FRG_DARK="\[\033[38;2;116;123;135m\]"
FRG_USER="\[\033[38;2;162;172;189m\]"
FRG_PATH="\[\033[38;2;178;172;191m\]"
SEP="𐌉"		# Needs an alternative on wls.exe (i.e. '❘')
PS1="$BOLD$FRG_DARK[$FRG_USER \u@\h $FRG_DARK$SEP$FRG_PATH \w $FRG_DARK❱$RESET "

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
