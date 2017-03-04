#!/bin/bash

###############################################################################
echo "Dock"
###############################################################################

echo "∙ Icon size of Dock items"
defaults write com.apple.dock tilesize -int 46

echo "∙ Lock the Dock size"
defaults write com.apple.dock size-immutable -bool true

echo "∙ Dock magnification"
defaults write com.apple.dock magnification -bool false

echo "∙ Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "∙ Auto-hide delay"
defaults write com.apple.dock autohide-delay -float 0

echo "∙ Show indicator lights for open applications"
defaults write com.apple.dock show-process-indicators -bool true

echo "∙ Remove all (default) app icons from the Dock"
defaults write com.apple.dock persistent-apps -array

echo "∙ Display translucent Dock icons for hidden applications"
defaults write com.apple.dock showhidden -bool true

echo "∙ Add iOS Simulator to Launchpad"
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
