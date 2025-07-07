#!/usr/bin/env bash
## dunst notifications toggle silent

notify="notify-send -u low dunst"

case `dunstctl is-paused` in
    true)
        dunstctl set-paused false
        $notify "Notifications are enabled" -i "$HOME/.local/share/image/dunst/notifications-enabled.png"
        ;;
    false)
        $notify "Notifications are paused" -i "$HOME/.local/share/image/dunst/notifications-disabled.png"
        # the delay is here because pausing notifications immediately hides
        # the ones present on your desktop; we also run dunstctl close so
        # that the notification doesn't reappear on unpause
        (sleep 3 && dunstctl close && dunstctl set-paused true) &
        ;;
esac
