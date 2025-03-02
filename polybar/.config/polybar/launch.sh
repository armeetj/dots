#!/bin/bash

killall -q polybar
# If all your bars have ipc enabled, you can use
# polybar-msg cmd quit

# if type "xrandr"; then
#         for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#                 MONITOR=$m polybar --reload main --config ./config.ini &
#         done
# else
polybar main --config=~/.config/polybar/config.ini &
# fi

echo "Bars launched..."
