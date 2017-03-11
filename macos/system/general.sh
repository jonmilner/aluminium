#!/bin/bash

###############################################################################
echo "General"
###############################################################################

echo "∙ Use Dark menu bar and Dock"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo "∙ Automatically hide and show the menu bar"
defaults write NSGlobalDomain "_HIHideMenuBar" -bool true

echo "∙ Sidebar icon size"
# Small  : 1
# Medium : 2
# Large  : 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "∙ Scroll bar visibility"
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
