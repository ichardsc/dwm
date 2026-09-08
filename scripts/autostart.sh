#!/bin/bash

xrandr -s 1920x1080 &
setxkbmap latam &
feh --bg-fill $HOME/.local/share/wallpapers/default-wallpaper.jpg &
spice-vdagent &
~/.local/bin/bar.sh &
