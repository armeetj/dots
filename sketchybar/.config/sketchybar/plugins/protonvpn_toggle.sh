#!/bin/sh

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

state=$(scutil --nc status ProtonVPN 2>/dev/null | sed -n '1p')

if [ "$state" = "Connected" ]; then
  scutil --nc stop ProtonVPN >/dev/null 2>&1
else
  open -a ProtonVPN >/dev/null 2>&1
fi

sleep 1
"$CONFIG_DIR/plugins/protonvpn.sh"
"$CONFIG_DIR/plugins/protonvpn_click.sh" on
