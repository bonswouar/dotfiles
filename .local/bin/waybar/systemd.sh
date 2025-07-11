#!/bin/sh
## From https://github.com/maximbaz/dotfiles/blob/main/modules/linux/bin/waybar-systemd

failed_user="$(systemctl --plain --no-legend --user list-units --state=failed | awk '{ print $1 }')"
failed_system="$(systemctl --plain --no-legend list-units --state=failed | awk '{ print $1 }')"

failed_systemd_count="$(echo -n "$failed_system" | grep -c '^')"
failed_user_count="$(echo -n "$failed_user" | grep -c '^')"

text=$(( failed_systemd_count + failed_user_count ))

if [ "$text" -eq 0 ]; then
    printf '{"text": ""}\n'
else
    tooltip=""

    [ -n "$failed_system" ] && tooltip="Failed system services:\n\n${failed_system}\n\n${tooltip}"
    [ -n "$failed_user" ]   && tooltip="Failed user services:\n\n${failed_user}\n\n${tooltip}"

    tooltip="$(printf "$tooltip" | perl -pe 's/\n/\\n/g' | perl -pe 's/(?:\\n)+$//')"

    printf '{"text": " %s", "tooltip": "%s" }\n' "$text" "$tooltip"
fi
