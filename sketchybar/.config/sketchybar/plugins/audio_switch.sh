#!/bin/sh

direction="$1"
uid="$2"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

[ -n "$direction" ] && [ -n "$uid" ] || exit 1

"$CONFIG_DIR/plugins/audio_devices.sh" set "$direction" "$uid" || exit 1

sleep 0.5
NAME=volume "$CONFIG_DIR/plugins/volume.sh"
"$CONFIG_DIR/plugins/volume_click.sh" on
