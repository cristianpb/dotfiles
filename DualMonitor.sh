#!/bin/bash

# set up the two monitors for bspwm
# NOTE This is a simplistic approach because I already know the settings I
# want to apply.
my_laptop_external_monitor=$(xrandr --query | grep 'VGA1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output VGA1 --mode 1920x1080 --rotate normal --right-of eDP1
else
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal
fi
