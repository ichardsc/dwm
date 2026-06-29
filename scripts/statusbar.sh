#!/bin/sh

while true; do
    VOL="$(pamixer --get-volume 2>/dev/null)%"
    MEM="$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    CPU="$(top -bn1 | awk '/Cpu/ {print int($2+$4)"%"}')"
    BAT="$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)%"
    TIME="$(date '+%H:%M')"

    WIFI_IP=$(ip -4 addr show wlan0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)
    ETH_IP=$(ip -4 addr show enp1s0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)

    # Wifi
    if [ -n "$WIFI_IP" ]; then
        WIFI="󰖩 $WIFI_IP"
    else
        WIFI="󰖩 off"
    fi

    # Ethernet
    if [ -n "$ETH_IP" ]; then
        ETH="󰈀 $ETH_IP"
    else
        ETH="󰈀 off"
    fi

    STATUS=" $VOL |  $MEM |  $CPU |  $BAT | $WIFI | $ETH |  $TIME"

    xsetroot -name "$STATUS"
    sleep 2
done

