#!/bin/sh
## inhibit lid switch for $1 seconds

sudo systemd-inhibit --what=handle-lid-switch sleep $1
