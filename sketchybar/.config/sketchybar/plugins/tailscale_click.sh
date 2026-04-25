#!/bin/sh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

status_json=$(tailscale status --json 2>/dev/null || printf '{}')
state=$(printf '%s\n' "$status_json" | jq -r '.BackendState // "Stopped"' 2>/dev/null)
online=$(printf '%s\n' "$status_json" | jq -r '.Self.Online // false' 2>/dev/null)
host=$(printf '%s\n' "$status_json" | jq -r '.Self.HostName // .Self.DNSName // "-"' 2>/dev/null)
ip=$(printf '%s\n' "$status_json" | jq -r '.Self.TailscaleIPs[0] // "-"' 2>/dev/null)

if [ "$state" = "Running" ] && [ "$online" = "true" ]; then
  action="Turn Off"
else
  action="Turn On"
fi

for index in 1 2 3 4; do
  peer=$(printf '%s\n' "$status_json" | jq -r --argjson index "$index" '
    (.Peer // {})
    | to_entries
    | sort_by(.value.HostName // .value.DNSName // "")
    | .[$index - 1].value
    | if . == null then empty
      else
        ((if (.Online // false) then "● " else "○ " end)
        + ((.HostName // .DNSName // "-") | sub("\\..*$"; ""))
        + " "
        + (.TailscaleIPs[0] // "-"))
      end
  ' 2>/dev/null)

  if [ -n "$peer" ]; then
    sketchybar --set "tailscale.popup.peer$index" label="$peer" drawing=on
  else
    sketchybar --set "tailscale.popup.peer$index" label="-" drawing=off
  fi
done

popup_state="${1:-toggle}"

sketchybar --set protonvpn popup.drawing=off \
           --set tailscale.popup.state label="$state" \
           --set tailscale.popup.host label="$host" \
           --set tailscale.popup.ip label="$ip" \
           --set tailscale.popup.toggle label="$action" \
           --set tailscale popup.drawing="$popup_state"
