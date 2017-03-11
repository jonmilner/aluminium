#!/bin/bash

###############################################################################
echo "Trackpad"
###############################################################################

echo "∙ Tap to click for this user and for the login screen"
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
