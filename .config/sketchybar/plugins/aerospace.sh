#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.color=0xff4e90de
else
    sketchybar --set $NAME icon.color=0xffffffff
fi
