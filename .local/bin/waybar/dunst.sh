#!/bin/sh
## Dunst notifications status for waybar

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%d days ' $D
  [[ $H > 0 ]] && printf '%d hours ' $H
  [[ $M > 0 ]] && printf '%d minutes ' $M
  [[ $D > 0 || $H > 0 || $M > 0 ]] && printf 'and '
  printf '%d seconds\n' $S
}

case `dunstctl is-paused` in
    true)
        waiting="`dunstctl count waiting`"
        if [[ $waiting -eq 0 ]]
        then
           icon=" "
        else
           icon=" "
           class="critical"
           tooltip="$waiting notification(s) waiting"
        fi
    ;;
    false)
        icon=" "
        count_history="$(dunstctl count history)"
        if [[ $count_history -eq 0 ]]
        then
            tooltip="0 notification"
        else
            IFS=$'\n'
            last_notif=($(dunstctl history | jq '.["data"][0][0]["timestamp"]["data"], .["data"][0][0]["appname"]["data"], .["data"][0][0]["summary"]["data"] '))
            last_notif_timestamp="${last_notif[0]}"
            last_notif_appname=$(echo "${last_notif[1]}" | tr -d '"')
            last_notif_summary=$(echo "${last_notif[2]}" | tr -d '"')
            # calculate actual time from dunst's (non-epoch) timestamp
            system_timestamp="$(cut -d'.' -f1 /proc/uptime)"
            how_long_ago=$((system_timestamp - last_notif_timestamp / 1000000))
            last_notif_time="$(displaytime $how_long_ago)"
            tooltip=$(printf 'Last: %s [%s]\\n%s ago' "$last_notif_summary" "$last_notif_appname" "$last_notif_time")
        fi
    ;;
esac

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$icon" "$tooltip" "$class"
