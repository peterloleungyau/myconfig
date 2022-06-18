#!/bin/sh

PRO=${1:-laptop_t480}

echo Use the profile ${PRO}

link_rc()
{
  TARG=~/"$1"
  mkdir -p ${TARG%/*}
  ln -sf ~/myconfig/${PRO}/"$1" ~/"$1"
}

link_rc .bashrc
link_rc .emacs
link_rc .gitconfig
link_rc .Xresources
link_rc .Xdefaults
link_rc .mplayer/config
#link_rc .xsession
#link_rc .xprofile
link_rc .config/i3/config
link_rc .i3status.conf
#link_rc calibrate_time.sh
#link_rc home.html
# for disabling anti-aliasing for large font sizes
link_rc .config/fontconfig
link_rc .config/guix/channels.scm

# for mounting

#
#mkdir -p ~/to_keep/Mail
#ln -sf ~/to_keep/Mail ~/Mail
#link_rc .mbsyncrc
