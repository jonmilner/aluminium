#!/bin/bash

###############################################################################
echo "General"
###############################################################################

echo "∙ Show battery percentage in menu bar"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

echo "∙ Use Dark menu bar and Dock"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo "∙ Automatically hide and show the menu bar"
defaults write NSGlobalDomain "_HIHideMenuBar" -bool true

echo "∙ Scroll bar visibility"
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
