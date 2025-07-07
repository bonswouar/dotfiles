#!/usr/bin/env bash
## Toggle TLP to fullcharge/conservation mode

tlp_stat="`sudo tlp-stat -b`"
notify="notify-send -u critical TLP"

if echo "$tlp_stat" | grep -q "conservation_mode = 1"; then
    sudo tlp fullcharge && $notify "Fullcharge enabled" -i "$HOME/.local/share/image/dunst/battery_charging.svg" ||  $notify "Fullcharge disabled\n<b>Not on AC</b>" -i "$HOME/.local/share/image/dunst/battery_2bar.svg"
else
    sudo tlp setcharge
    $notify "Fullcharge disabled" -i "$HOME/.local/share/image/dunst/battery_2bar.svg"
fi
