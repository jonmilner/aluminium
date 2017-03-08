#!/bin/bash

###############################################################################
echo "Date & Time"
###############################################################################

echo "∙ Format menu bar clock"
# "h:mm" Default
# "HH"   Use a 24-hour clock
# "a"    Show AM/PM
# "ss"   Display the time with seconds
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d h:mm:ss a"
