#!/bin/bash

export LOCALE='en_US.UTF-8'

xsetroot -cursor_name left_ptr -solid "#262626"

# Set all of this here as a hack to make it easier to
# automatically switch between monitors and keyboards/mice
xinput set-prop 'pointer:Logitech Wireless Mouse MX Master' \
       'libinput Natural Scrolling Enabled' 1
xinput set-prop 'pointer:ETPS/2 Elantech Touchpad' \
       'libinput Natural Scrolling Enabled' 1
xinput set-prop 'pointer:Magic Mouse 2' \
       'libinput Natural Scrolling Enabled' 1

setxkbmap dvorak
xmodmap ~/.Xmodmap
xset r 66 # Make the remapped capslock repeat

xrandr --auto
xrandr --output eDP-1 --mode 1280x720

# HDMI-2 connected 1920x810+0+0 (normal left inverted right x axis y axis) 673mm x 284mm
# if [[ $(xrandr | grep 'HDMI-2 connected') ]]; then
#   xrandr --newmode "1920x810_60.00"  127.50  1920 2024 2224 2528  810 813 823 841 -hsync +vsync
#   xrandr --addmode HDMI-2 1920x810_60.00
#   xrandr --output HDMI-2 --mode 1920x810_60.00
#   xrandr --output HDMI-2 --left-of eDP-1
if [[ $(xrandr | grep 'DP-1 connected.*673mm') ]]; then
  xrandr --newmode "1920x810_60.00"  127.50  1920 2024 2224 2528  810 813 823 841 -hsync +vsync
  xrandr --addmode DP-1 1920x810_60.00
  xrandr --output DP-1 --mode 1920x810_60.00
  xrandr --output DP-1 --left-of eDP-1
elif [[ $(xrandr | grep 'DP-1 connected') ]]; then
  xrandr --output DP-1 --mode 1280x800
  xrandr --output eDP-1 --same-as DP-1
fi

[[ $(pgrep redshift) ]] || redshift &

[[ $(pgrep xmobar) ]] || xmobar ~/.xmonad/xmobar.hs &

dropbox start

xrdb ~/.Xresources -D$(hostname)
