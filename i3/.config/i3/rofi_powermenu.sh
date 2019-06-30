#!/bin/bash
action=$(echo -e "Lock Screen\nLogout\nShutdown\nScreenshot\nReboot" | rofi -dmenu -p "power:")

if [[ "$action" == "Lock Screen" ]]
then
    $HOME/.dotfiles/blur.sh
fi

if [[ "$action" == "Logout" ]]
then
    i3-msg exit
fi

if [[ "$action" == "Shutdown" ]]
then
    shutdown now
fi

if [[ "$action" == "Screenshot" ]]
then
    scrot -s ~/Images/`date +%Y-%m-%d_%H:%M:%S`.png
fi


if [[ "$action" == "Reboot" ]]
then
    reboot
fi
