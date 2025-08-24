#!/bin/sh

COLOR_CONNECTED="#a5fb8f"
COLOR_CONNECTING="#FAE3B0"
COLOR_DISCONNECTED="#f087bd"

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep wireguard | head -1 | cut -d ':' -f 1)"

if [ -n "$vpn" ]; then
  echo "%{F$COLOR_CONNECTED}%{F-}"
else
  echo "%{F$COLOR_DISCONNECTED}  No VPN%{F-}" && nmcli con up id VPNNP-cbe213
fi
