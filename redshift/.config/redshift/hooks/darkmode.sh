#!/bin/sh

if [ "$1" = period-changed ]; then
	case $3 in
		night)
            echo From day to night
            cp ${HOME}/.Xresources.dark ${HOME}/.Xresources
            xrdb ${HOME}/.Xresources
            sed -i -E "s/\"set background=dark/set background=dark/" ${HOME}/.vimrc
            sed -i -E "s/set background=light/\"set background=light/" ${HOME}/.vimrc
            ;;
        daytime)
            echo From night to day
            cp ${HOME}/.Xresources.light ${HOME}/.Xresources
            xrdb ${HOME}/.Xresources
            sed -i -E "s/set background=dark/\"set background=dark/" ${HOME}/.vimrc
            sed -i -E "s/\"set background=light/set background=light/" ${HOME}/.vimrc
            ;;
	esac
fi
