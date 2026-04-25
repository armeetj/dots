#!/bin/sh

status=$(scutil --nc status ProtonVPN 2>/dev/null)
state=$(printf '%s\n' "$status" | sed -n '1p')
changed=$(printf '%s\n' "$status" | awk -F': ' '/LastStatusChangeTime/ {print $2; exit}')

[ -n "$state" ] || state="Unknown"
[ -n "$changed" ] || changed="-"

if [ "$state" = "Connected" ]; then
  action="Turn Off"
else
  action="Open App"
fi

popup_state="${1:-toggle}"

sketchybar --set tailscale popup.drawing=off \
           --set protonvpn.popup.state label="$state" \
           --set protonvpn.popup.changed label="$changed" \
           --set protonvpn.popup.toggle label="$action" \
           --set protonvpn popup.drawing="$popup_state"
