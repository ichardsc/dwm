#!/bin/sh

while true; do
    VOL="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{gsub(/\./, ","); print int($2*100)}')$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 'M' || echo '%')"
    MEM="$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    CPU="$(top -bn1 | awk '/Cpu/ {print int($2+$4)"%"}')"
    BAT="$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)%"
    TIME="$(date '+%H:%M')"

    WIFI_IP=$(ip -4 addr show wlo1 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)
    ETH_IP=$(ip -4 addr show enp1s0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)

    if [ -n "$WIFI_IP" ]; then
        WIFI="^c#89b4fa^󰖩 $WIFI_IP^d^"
    else
        WIFI="^c#555555^󰖩 ^d^"
    fi

    if [ -n "$ETH_IP" ]; then
        ETH="^c#a6e3a1^󰈀 $ETH_IP^d^"
    else
        ETH="^c#555555^󰈀 ^d^"
    fi

    STATUS="\
^b#222222^^c#cdd6f4^ $VOL^d^\
^c#6c7086^ | ^d^\
^b#222222^^c#cdd6f4^ $MEM^d^\
^c#6c7086^ | ^d^\
^b#222222^^c#fab387^ $CPU^d^\
^c#6c7086^ | ^d^\
^b#222222^^c#f9e2af^ $BAT^d^\
^c#6c7086^ | ^d^\
$WIFI\
^c#6c7086^ | ^d^\
$ETH\
^c#6c7086^ | ^d^\
^b#222222^^c#f9e2af^ $TIME^d^"

    xsetroot -name "$STATUS"
    sleep 2
done

