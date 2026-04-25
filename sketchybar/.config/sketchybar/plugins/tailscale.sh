#!/bin/sh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

status_json=$(tailscale status --json 2>/dev/null || printf '{}')
state=$(printf '%s\n' "$status_json" | jq -r '.BackendState // "Stopped"' 2>/dev/null)
online=$(printf '%s\n' "$status_json" | jq -r '.Self.Online // false' 2>/dev/null)

if [ "$state" = "Running" ] && [ "$online" = "true" ]; then
  sketchybar --set "$NAME" label="TS" label.color=0xffffa657
else
  sketchybar --set "$NAME" label="TS" label.color=0xff5f6673
fi
