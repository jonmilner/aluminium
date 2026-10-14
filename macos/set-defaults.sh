#!/bin/bash

# Close any open System Settings panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Settings" to quit'

###############################################################################
# Set Preferences
###############################################################################

dir="$(cd "$(dirname "$0")" && pwd)"

for f in "$dir"/apps/*.sh "$dir"/system/*.sh; do
  source "$f"
done
