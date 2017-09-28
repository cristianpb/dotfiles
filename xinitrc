# Paste using middle clic
syndaemon -i 0.5 -t -K -R -d
# Hide pointer when no needed
#unclutter &
# SSH agent
eval "$(ssh-agent -s)"
# Network Manager applet
#>> /dev/null which nm-applet && nm-applet &
#>> /dev/null which blueman-applet && blueman-applet &
exec i3
