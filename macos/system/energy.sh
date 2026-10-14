#!/bin/bash

###############################################################################
echo "Energy"
###############################################################################

# Laptops only. On power, never sleep while open, so background jobs keep
# running; the display can still turn off. Closing the lid still sleeps, unless
# an external display is connected. Battery settings stay at the macOS defaults.
if pmset -g batt | grep -q InternalBattery; then
  echo "∙ On power: don't sleep while the display is off"
  sudo pmset -c sleep 0
fi
