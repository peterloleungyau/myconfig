#!/run/current-system/profile/bin/sh

########################################################################
##  Merge in defaults and keymaps                                     ##
########################################################################

userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap

#if [ -f $sysresources ]; then
#    /usr/bin/xrdb -merge $sysresources
#fi
#
#if [ -f $sysmodmap ]; then
#    /usr/bin/xmodmap $sysmodmap
#fi

if [ -f $userresources ]; then
    $HOME/.guix-profile/bin/xrdb -merge $userresources
fi

#if [ -f $usermodmap ]; then
#    /usr/bin/xmodmap $usermodmap
#fi

###
# set the mouse speed for the trackball
# the device id is found to be 12 using 'xinput list'
# and the "Device Accel Velocity Scaling" prop is found to be 262 using 'xinput list-props 12'
#xinput --set-prop 12 262 2.0
# to set the scroll to be less sensitive, again 268 is the property id of 'Evdev Scrolling Distance'
#xinput --set-prop 12 268 2 1 1
# to decrease acceleration
#xinput --set-prop 12 260 2.0

#xinput --set-button-map "ELECOM TrackBall Mouse HUGE TrackBall" 1 2 3 4 5 6 7 2 1 10 11 12 13
#xinput --set-button-map "USB OPTICAL MOUSE" 1 2 3 4 5 6 7 2 9 10 11 12 13

########################################################################
##  start desktop
########################################################################
xprofile=$HOME/.xprofile

if [ -f $xprofile ]; then
    . $xprofile
fi

case "$DESKTOP_SESSION" in
  xfce)
    exec /run/current-system/profile/bin/dbus-launch --exit-with-session /run/current-system/profile/bin/startxfce4
    ;;
  i3)
    exec /run/current-system/profile/bin/dbus-launch --exit-with-session /run/current-system/profile/bin/i3
    ;;
  openbox)
    exec /run/current-system/profile/bin/dbus-launch --exit-with-session /run/current-system/profile/bin/openbox
    ;;
  *)
    exec /run/current-system/profile/bin/dbus-launch --exit-with-session /run/current-system/profile/bin/startxfce4
    ;;
esac
