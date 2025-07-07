#!/bin/sh
## Show current screen refresh rate in waybar

outputs=$(swaymsg -t get_outputs)
rate=`echo "$outputs" | jq  '.[0] .["current_mode"] .["refresh"]'`
resolution=`echo "$outputs" | jq  '.[0] .["current_mode"] .["width"], .[0] .["current_mode"]  .["height"]' | paste -d "x"  - -`
printf '{"text": "%sHz", "tooltip": "%s", "class": ""}\n' "`expr $rate / 1000`" "$resolution"
