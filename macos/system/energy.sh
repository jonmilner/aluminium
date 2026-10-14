#!/bin/bash

###############################################################################
echo "Energy"
###############################################################################

# On power, never sleep by itself, so background jobs keep running; the
# display can still turn off. On a laptop, closing the lid still sleeps unless
# an external display is connected, and battery settings stay at the defaults.
echo "∙ On power: don't sleep while the display is off"
sudo pmset -c sleep 0
