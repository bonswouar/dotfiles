#!/bin/sh
## From https://github.com/maximbaz/dotfiles/blob/main/overlay/bin/sway-unfullscreen

swaymsg -t subscribe -m '[ "window" ]' | while read -r line; do
    if [ "$(echo "$line" | jq -r '.change')" = "new" ]; then
        if [ "$(swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true).fullscreen_mode')" -eq 1 ]; then
            swaymsg fullscreen disable
            swaymsg [con_id="$(echo "$line" | jq -r '.container.id')"] focus
        fi
    fi
done
