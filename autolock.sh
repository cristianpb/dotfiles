#!/bin/sh

set -eu

# This script is intended to be run as the xautolock locker and notifier.
# It requires i3lock, and dunst is optional.

# Copy or link this script as /usr/bin/slock to let xfce4-session run it.
if [ "$(basename "$0")" = "slock" ]; then
  cmd=lock
else
  cmd=${1:-lock}
fi

# Is the screen already locked?
locked() { pkill -0 --euid "$(id -u)" --exact i3lock; }

# Return 0 if suspend is acceptable.
suspend_ok() {
  [ -n "$(2>/dev/null mpc current)" ] && return 1
  return 0
}

# Print the given message with a timestamp.
info() { printf '%s\t%s\n' "$(date)" "$*"; }

log() {
  if [ -n "${LOCK_LOG:-}" ]; then
    info >>"$LOCK_LOG" "$@"
  else
    info "$@"
  fi
}

# Control the dunst daemon, if it is running.
dunst() {
  pkill -0 --exact dunst || return 0

  case ${1:-} in
    stop)
      log "Stopping notifications and locking screen."
      pkill -USR1 --euid "$(id -u)" --exact dunst
      ;;
    resume)
      log "...Resuming notifications."
      pkill -USR2 --euid "$(id -u)" --exact dunst
      ;;
    *)
      echo "dunst argument required: stop or resume"
      return 1
      ;;
  esac
}

blur() {
  IMAGE=/tmp/i3lock.png
  SCREENSHOT="scrot $IMAGE" # 0.46s
  
  # Get the screenshot, add the blur and lock the screen with it
  $SCREENSHOT
  convert $IMAGE -scale 10% -scale 1000% $IMAGE
  i3lock -i $IMAGE --nofork -f
  rm $IMAGE
  watson stop
}

case "$cmd" in
  lock)
    dunst stop

    # Fork both i3lock and its monitor to avoid blocking xautolock.
    blur &

    pid="$!"
    log "Waiting for PID $pid to end..."
    while 2>/dev/null kill -0 "$pid"; do
      sleep 1
    done

    dunst resume
    ;;

  notify)
    # Notification should not be issued while locked even if dunst is paused.
    locked && exit

    log "Sending notification."
    # grep finds either Xautolock.notify or Xautolock*notify
    secs="$(xrdb -query | grep -m1 '^Xautolock.notify' | cut -f2)"
    test -n "$secs" && secs="Locking in $secs seconds"

    notify-send --urgency="normal" --app-name="xautolock" \
      --icon='/usr/share/icons/Adwaita/48x48/emblems/emblem-readonly.png' \
      -- "Screen Lock" "$secs"
    ;;

  suspend)
    if suspend_ok; then
      log "Suspending system."
      systemctl suspend
    else
      log "Deferring suspend."
    fi
    ;;

  debug)
    log "$@"
    ;;

  *)
    log "Unrecognized option: $1"
esac
