#!/bin/sh

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

script="$CONFIG_DIR/plugins/audio_devices.swift"
cache="${TMPDIR:-/tmp}/sketchybar-audio-devices"

if [ ! -x "$cache" ] || [ "$script" -nt "$cache" ]; then
  swiftc "$script" -o "$cache" || exit 1
fi

exec "$cache" "$@"
