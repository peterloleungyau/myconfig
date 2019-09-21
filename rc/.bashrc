# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
export TERM=xterm-color
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# add path
# Taken and modified from https://gist.github.com/168835
export PS1="$PS1\[\033[0;33m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[01;32m\]\[\033[00m\]\$ "
# This will change your prompt to display not only your working directory but also your current git branch, if you have one. Pretty nifty!

export EDITOR='emacs --no-splash'
alias editor=$EDITOR
#alias git="PATH=~/mybin:$PATH git"
alias fplay="mplayer -af scaletempo -fs -zoom -framedrop -osdlevel 3"
alias afplay="mplayer -af scaletempo -aspect 4:3 -fs -zoom -framedrop -osdlevel 3"
alias fmplay="mplayer -af scaletempo"
alias ydown="youtube-dl --no-playlist -f 22/18"
alias ylist="youtube-dl -o 'v%(playlist_index)s_%(title)s.%(ext)s'"

export SBCL_HOME=/usr/lib64/sbcl
export LESS=-R

# to play youtube videos
function yuplay {
	youtube-dl -o - "${@}" | mplayer -zoom -fs -
}

function rplay {
	sort -R "${@}" | while read p; do
		echo "$p"
		url=$(echo "$p" | cut -d' ' -f1)
		yplay.sh "$url" -q >/dev/null 2>&1
		if ! sleep 2; then
			break
		fi
	done
}

function bplay {
	sort -R "${@}" | while read p; do
		echo "$p"
		url=$(echo "$p" | cut -d' ' -f1)
		COOKIE_FILE=/var/tmp/youtube-dl-bg-cookies.txt
		#mplayer -af scaletempo -noconsolecontrols -vo null -cookies -cookies-file ${COOKIE_FILE} $(youtube-dl -g --cookies ${COOKIE_FILE} "$url")
		youtube-dl -f 140 -o - "$url" | mplayer -cache 8000 -vo null -
		if ! sleep 2; then
			break
		fi
	done

}

function mark_watched {
	mv "$1" "watched_$1"
}

## image viewer: sxiv
alias viewimg="sxiv"

