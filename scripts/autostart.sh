#!/bin/bash

xrandr -s 1920x1080 &
setxkbmap latam &
feh --bg-fill ~/downloads/tux.jpg &
spice-vdagent &
~/.local/bin/bar.sh &
