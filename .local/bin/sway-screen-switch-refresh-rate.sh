#!/bin/sh
## sway > switch to next supported refresh rate

notify="notify-send -u low sway -i $HOME/.local/share/image/dunst/screen.svg"

outputs=$(swaymsg -t get_outputs)

mode=$(echo "$outputs" | jq  '.[0] .["current_mode"] ')
width=$(echo "$mode" | jq '.["width"]')
height=$(echo "$mode" | jq '.["height"]')
output_name=$(echo "$outputs" | jq '.[0] .["name"]')
rates=$(echo "$outputs" | jq  "`printf '.[0] .["modes"] .[] | select((.width==%s) and (.height=%s))' "$width" "$height"`" | jq '.["refresh"]' | sort | uniq)
current_rate=$(echo "$mode" | jq  '.["refresh"]')

_switch_sway_output_rate() {
    swaymsg "output ${output_name} mode ${width}x${height}@${1}.000Hz"
    $notify "Screen changed to ${1}Hz"
    return 0
}

# select next refresh rate
passed_current=""
while IFS= read -r rate; do
    if echo $current_rate | grep $rate > /dev/null; then
        passed_current="1"
    else
        if [[ $passed_current ]]; then
            rate=$((rate/1000))
            _switch_sway_output_rate "$rate"
            exit
        fi
    fi
done <<< "$rates"

# if not found (i.e current rate is the last one), use first rate
rate=$(("$(echo "$rates" | head -n 1)"/1000))
_switch_sway_output_rate "$rate"
