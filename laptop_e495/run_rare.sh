#!/bin/sh

GUIX_PROFILE="/home/peter/.guix-extra-profiles/extra_pkgs/extra_pkgs"
. "$GUIX_PROFILE/etc/profile"
exec $@
