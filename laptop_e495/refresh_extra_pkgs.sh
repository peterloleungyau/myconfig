#!/bin/sh

guix time-machine -C channels.scm -- package -m e495_extra_pkgs.scm --profile="$GUIX_EXTRA_PROFILES"/extra_pkgs/extra_pkgs

# to activate the profile in shell
# GUIX_PROFILE="/home/peter/.guix-extra-profiles/extra_pkgs/extra_pkgs"
# . "$GUIX_PROFILE/etc/profile"
