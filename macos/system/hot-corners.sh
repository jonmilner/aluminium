#!/bin/bash

###############################################################################
echo "Hot Corners"
###############################################################################

# Possible values:
#   0: no-op
#   2: Mission Control
#   3: Show application windows
#   4: Desktop
#   5: Start screen saver
#   6: Disable screen saver
#   7: Dashboard
#  10: Put display to sleep
#  11: Launchpad
#  12: Notification Center

echo "∙ Hot Corner: Top Left — Mission Control"
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

echo "∙ Hot Corner: Top Right — None"
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

echo "∙ Hot Corner: Bottom Left — None"
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

echo "∙ Hot Corner: Bottom Right — Desktop"
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
