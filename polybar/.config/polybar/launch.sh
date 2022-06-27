#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for m in $(polybar-git --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar-git -l error --reload top &
done

echo "Bars launched..."
