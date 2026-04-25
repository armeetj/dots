#!/bin/sh

sid="${1:-${NAME#space.}}"
inactive_color="${SPACE_BG_INACTIVE:-0x00000000}"
default_color="${SPACE_BG_DEFAULT:-0x33ffffff}"

if [ "$SENDER" = "mouse.clicked" ]; then
  yabai -m space --focus "$sid" >/dev/null 2>&1
  exit $?
fi

case "$SELECTED" in
  on|true|1) selected=true ;;
  *) selected=false ;;
esac

if [ "$selected" != "true" ]; then
  sketchybar --set "$NAME" background.drawing=off background.color="$inactive_color"
  exit 0
fi

sketchybar --set "$NAME" background.drawing=on background.color="$default_color"
