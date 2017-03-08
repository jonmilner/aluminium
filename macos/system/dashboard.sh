#!/bin/bash

###############################################################################
echo "Dashboard"
###############################################################################

echo "∙ Turn Off Dashboard"
# 1: Off
# 2: As Space
# 3: As Overlay
defaults write com.apple.dashboard enabled-state -int 1

echo "∙ Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "∙ Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true
