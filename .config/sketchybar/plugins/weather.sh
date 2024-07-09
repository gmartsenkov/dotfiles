#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.


sketchybar --set "$NAME" label="$(curl -s "wttr.in/Huntingdon?format=1&m")"
