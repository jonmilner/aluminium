#!/bin/bash

###############################################################################
echo "Date & Time"
###############################################################################

echo "∙ Format menu bar clock"
# e.g. "Tue Oct 14 7:58:09 AM". DateFormat is no longer read.
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 1 # 0 when space allows, 1 always, 2 never
defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults write com.apple.menuextra.clock Show24Hour -bool false
defaults write com.apple.menuextra.clock ShowAMPM -bool true
