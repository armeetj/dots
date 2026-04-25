#!/bin/sh

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

output_devices=$("$CONFIG_DIR/plugins/audio_devices.sh" list output 2>/dev/null)
input_devices=$("$CONFIG_DIR/plugins/audio_devices.sh" list input 2>/dev/null)
popup_state="${1:-toggle}"
output_file=$(mktemp)
input_file=$(mktemp)

printf '%s\n' "$output_devices" > "$output_file"
printf '%s\n' "$input_devices" > "$input_file"

current_output=$(printf '%s\n' "$output_devices" | awk -F '\t' '$1 == "*" {print $3; exit}')
current_input=$(printf '%s\n' "$input_devices" | awk -F '\t' '$1 == "*" {print $3; exit}')

[ -n "$current_output" ] || current_output="-"
[ -n "$current_input" ] || current_input="-"

sketchybar --set volume.popup.output_current icon.drawing=off label="Output  $current_output" \
           --set volume.popup.input_current icon.drawing=off label="Input   $current_input"

index=1
while IFS="$(printf '\t')" read -r marker uid name; do
  [ -n "$uid" ] && [ -n "$name" ] || continue
  [ "$index" -le 5 ] || break

  label="  $name"
  color="0xffffffff"
  [ "$marker" = "*" ] && label="* $name" && color="0xff8bd49c"

  sketchybar --set "volume.popup.output$index" \
    drawing=on \
    icon.drawing=off \
    label="$label" \
    label.color="$color" \
    click_script="$CONFIG_DIR/plugins/audio_switch.sh output '$uid'"

  index=$((index + 1))
done < "$output_file"

while [ "$index" -le 5 ]; do
  sketchybar --set "volume.popup.output$index" drawing=off label="-"
  index=$((index + 1))
done

index=1
while IFS="$(printf '\t')" read -r marker uid name; do
  [ -n "$uid" ] && [ -n "$name" ] || continue
  [ "$index" -le 5 ] || break

  label="  $name"
  color="0xffffffff"
  [ "$marker" = "*" ] && label="* $name" && color="0xff8bd49c"

  sketchybar --set "volume.popup.input$index" \
    drawing=on \
    icon.drawing=off \
    label="$label" \
    label.color="$color" \
    click_script="$CONFIG_DIR/plugins/audio_switch.sh input '$uid'"

  index=$((index + 1))
done < "$input_file"

while [ "$index" -le 5 ]; do
  sketchybar --set "volume.popup.input$index" drawing=off label="-"
  index=$((index + 1))
done

sketchybar --set tailscale popup.drawing=off \
           --set protonvpn popup.drawing=off \
           --set volume popup.drawing="$popup_state"

rm -f "$output_file" "$input_file"
