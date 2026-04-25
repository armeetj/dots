#!/bin/sh

if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

status=$(scutil --nc list 2>/dev/null | awk '/"ProtonVPN"/ {print $2; exit}')

if [ "$status" = "(Connected)" ]; then
  sketchybar --set "$NAME" label="VPN" label.color=0xffff7eb6
else
  sketchybar --set "$NAME" label="VPN" label.color=0xff5f6673
fi
