#  _           _
# | |_ ___ ___| |_ ___ ___
# | . | .'|_ -|   |  _|  _|
# |___|__,|___|_|_|_| |___|
#
# This is ale's ~/.bashrc

#if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [[ "$-" =~ i ]]; then
#	exec tmux
#fi

# Bash
export HISTSIZE=-1
export HISTCONTROL="ignoreboth"
shopt -s histappend

# Environment variables
export PATH="$PATH:$HOME/.local/bin"
export EDITOR="nvim"
export LESS="-RFi"
export PYTHONSTARTUP="$HOME/.pyrc"
export GOPATH="$HOME/.go"
export MANROFFOPT="-c"	# See https://bbs.archlinux.org/viewtopic.php?pid=2113876#p2113876
#export LS_COLORS+=":ow=01;34"	# Hide ugly o+w color (on NTFS)

# PS1
BOLD="\[\033[1m\]"
RESET="\[\033[0m\]"
FG_DARK="\[\033[38;5;242m\]"
FG_USER="\[\033[38;5;12m\]"
FG_PATH="\[\033[38;5;13m\]"
PS1="$BOLD$FG_DARK[$FG_USER \u@\h $FG_DARK][$FG_PATH \W $FG_DARK] »$RESET "

# Greetings
FACES=(
	'( ._.)' '( .-.)' '( ^_^)'
	'( ;-;)' '( `-`)' '( -.-)'
	"( '.')" '( +_+)' '( o_o)'
	'( •-•)' '( °.°)' '( ×_×)'
	'( ~_~)' '( #-#)' '( T-T)'
)
if [[ "$-" =~ i ]]; then	# Show only if shell is interactive
	echo ${FACES[$(shuf -n 1 -i 0-$((${#FACES[@]} - 1)))]}
fi

# Aliases
alias sudo="sudo "	# See https://unix.stackexchange.com/a/349290
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias dd="dd status=progress"
alias crypt="openssl aes-256-cbc -pbkdf2 -a -A"	# -e/-d for encrypt/decrypt
alias sandbox="unshare --map-current-user --map-auto bwrap --unshare-all --bind / / --proc /proc --dev /dev"
alias bottles-cli="flatpak run --command=bottles-cli com.usebottles.bottles"

# Functions
function now {
	date +%s%N | cut -b -13
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
function overlay {
	parent=$(mktemp -d "/tmp/overlay.XXXXXXXXXX")
	mkdir $parent/{changes,buffer}
	sudo bwrap --bind / / --overlay-src / --overlay $parent/changes $parent/buffer / --proc /proc --dev /dev $@
}
