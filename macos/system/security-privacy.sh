#!/bin/bash

###############################################################################
echo "Security & Privacy"
###############################################################################

echo "∙ Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 5

echo "∙ Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "∙ Allow applications downloaded from anywhere"
sudo spctl --master-disable
