#!/bin/bash

# set up the two monitors for bspwm
# NOTE This is a simplistic approach because I already know the settings I
# want to apply.
my_laptop_external_monitor=$(xrandr --query | grep 'DP-1-3')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 192x1200 --rotate normal --output DP-1-1 --off --output HDMI-1 --off --output DP-1-3 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1-2 --off --output DP-1 --off --output HDMI-2 --off
else
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP-1-1 --off --output HDMI-1 --off --output DP-1-3 --off --output DP-1-2 --off --output DP-1 --off --output HDMI-2 --off
fi
