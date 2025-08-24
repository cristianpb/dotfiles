#!/bin/bash

set -e

for p in $(seq 0 2 100); do
    dunstify --icon preferences-desktop-screensaver \
        -h int:value:$p \
        -h 'string:hlcolor:#ff4444' \
        -h string:x-dunst-stack-tag:progress-lock \
        --timeout=500 "about to lock screen ..." "move or use corners"
    sleep 0.05
done




#!/bin/sh

set -e

primary=$(xrandr | grep " primary" | cut -f1 -d " " | head -n 1)

# decreasing brightness
trap "xrandr --output $primary --gamma 1" EXIT
for g in $(LANG=C seq 1 -0.02 0.4) ; do
    xrandr --output $primary --brightness $g
    sleep 0.01
done

# increasing brightness
for g in $(LANG=C seq 0.4 +0.02 1) ; do
    xrandr --output $primary --brightness $g
    sleep 0.01
done



