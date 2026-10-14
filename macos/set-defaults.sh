#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Set Preferences
###############################################################################

dir="$(cd "$(dirname "$0")" && pwd)"

for f in "$dir"/apps/*.sh "$dir"/system/*.sh; do
  source "$f"
done
