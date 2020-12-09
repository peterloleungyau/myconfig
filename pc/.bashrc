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
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
alias ydown="youtube-dl --no-check-certificate --no-playlist -f 22/18"
alias ylist="youtube-dl --no-check-certificate -o 'v%(playlist_index)s_%(title)s.%(ext)s'"

export SBCL_HOME=/usr/lib64/sbcl
export LESS=-R

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

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

function link_rc {
  TARG=~/"$1"
  mkdir -p ${TARG%/*}
  ln -sf ~/myconfig/rc/"$1" ~/"$1"
}

## image viewer: sxiv
alias viewimg="sxiv"

export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
export PATH="/home/peter/.guix-profile/bin${PATH:+:}$PATH"
export PATH="/home/peter/.config/guix/current/bin${PATH:+:}$PATH"

GUIX_PROFILE="/home/peter/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

export XDG_DATA_DIRS="$HOME/.guix-profile/share${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"
export GIO_EXTRA_MODULES="$HOME/.guix-profile/lib/gio/modules${GIO_EXTRA_MODULES:+:}$GIO_EXTRA_MODULES"

# set the mouse speed for the trackball
# the device id is found to be 10 using 'xinput list'
# and the "Device Accel Velocity Scaling" prop is found to be 262 using 'xinput list-props 10'
#xinput --set-prop 10 262 2.0
# to set the scroll to be less sensitive, again 268 is the property id of 'Evdev Scrolling Distance'
#xinput --set-prop 10 268 2 1 1
# to decrease acceleration
#xinput --set-prop 10 260 2.0
xinput --set-button-map "ELECOM TrackBall Mouse HUGE TrackBall" 1 2 3 4 5 6 7 2 1 10 11 12 13
