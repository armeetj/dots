#!/bin/sh

calendar=$(cal)
today=$(date '+%e' | tr -d ' ')
today_row=""
today_col=""
line_no=0
calendar_file=$(mktemp)

printf '%s\n' "$calendar" > "$calendar_file"

while IFS= read -r line; do
  line_no=$((line_no + 1))

  case "$line_no" in
    1)
      sketchybar --set clock.popup.header label="$(printf '%s' "$line" | sed 's/^ *//; s/ *$//')"
      ;;
    2)
      sketchybar --set clock.popup.weekdays label="$line"
      ;;
    3|4|5|6|7|8)
      row=$((line_no - 2))
      clean_line="$line"
      row_color="0xffffffff"

      for col in 1 2 3 4 5 6 7; do
        day=$(printf '%s\n' "$line" | cut -c $((col * 3 - 2))-$((col * 3)) | tr -d ' ')
        if [ "$day" = "$today" ]; then
          today_row="$row"
          today_col="$col"
          row_color="0xffff5f7a"
        fi
      done

      fixed_line=$(printf '%s\n' "$clean_line" | sed 's/ / /g')
      sketchybar --set "clock.popup.week$row" label="$fixed_line" label.color="$row_color"
      ;;
  esac
done < "$calendar_file"

sketchybar --set clock.popup.today drawing=off

rm -f "$calendar_file"

sketchybar --set volume popup.drawing=off \
           --set tailscale popup.drawing=off \
           --set protonvpn popup.drawing=off \
           --set clock popup.drawing=toggle
