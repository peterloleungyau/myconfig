#!/bin/sh

function link_rc {
  ln -s ~/myconfig/rc/"$1" ~/"$1"
}

link_rc .bashrc
link_rc .newsbeuter/config
link_rc .newsbeuter/urls
link_rc .emacs
link_rc .gitconfig
link_rc .Xresources
link_rc .mplayer/config
link_rc .xinitrc
link_rc calibrate_time.sh
link_rc home.html
