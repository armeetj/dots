#!/bin/sh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

space_json=$(yabai -m query --spaces --space 2>/dev/null || printf 'null')
space_index=$(printf '%s\n' "$space_json" | jq -r '(.index // empty)' 2>/dev/null)
windows_json=$(yabai -m query --windows --space "$space_index" 2>/dev/null || printf '[]')

window_fullscreen=$(printf '%s\n' "$windows_json" | jq -r 'any(.[]; ((."is-visible" // false) and ((."is-native-fullscreen" // false) or (."has-fullscreen-zoom" // false))))' 2>/dev/null || printf 'false')
window_floating=$(printf '%s\n' "$windows_json" | jq -r 'any(.[]; ((."is-visible" // false) and ((."is-floating" // false) or (.floating // false))))' 2>/dev/null || printf 'false')
space_fullscreen=$(printf '%s\n' "$space_json" | jq -r '(."is-native-fullscreen" // false)' 2>/dev/null || printf 'false')
space_type=$(printf '%s\n' "$space_json" | jq -r '(.type // "")' 2>/dev/null || printf '')

if [ "$window_fullscreen" = "true" ] || [ "$space_fullscreen" = "true" ]; then
  mode=fullscreen
elif [ "$window_floating" = "true" ] || [ "$space_type" = "float" ]; then
  mode=floating
else
  mode=tiled
fi

case "$mode" in
  fullscreen)
    sketchybar --set "$NAME" \
      drawing=on \
      label="▣" \
      label.color=0xffffd166 \
      background.drawing=off
    ;;
  floating)
    sketchybar --set "$NAME" \
      drawing=on \
      label="◇" \
      label.color=0xff7dd3fc \
      background.drawing=off
    ;;
  *)
    sketchybar --set "$NAME" \
      drawing=on \
      label="□" \
      label.color=0xff9aa4b2 \
      background.drawing=off
    ;;
esac
