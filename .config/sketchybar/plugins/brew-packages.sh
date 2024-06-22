#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

brew update
sketchybar --set "$NAME" label="$(brew outdated | bb -i '(count *input*)')"
