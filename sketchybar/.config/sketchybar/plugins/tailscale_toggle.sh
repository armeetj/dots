#!/bin/sh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

status_json=$(tailscale status --json 2>/dev/null || printf '{}')
state=$(printf '%s\n' "$status_json" | jq -r '.BackendState // "Stopped"' 2>/dev/null)
online=$(printf '%s\n' "$status_json" | jq -r '.Self.Online // false' 2>/dev/null)

if [ "$state" = "Running" ] && [ "$online" = "true" ]; then
  tailscale down >/dev/null 2>&1
else
  tailscale up >/dev/null 2>&1
fi

sleep 1
"$CONFIG_DIR/plugins/tailscale.sh"
"$CONFIG_DIR/plugins/tailscale_click.sh" on
