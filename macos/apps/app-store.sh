#!/bin/bash

###############################################################################
echo "App Store"
###############################################################################

echo "∙ Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "∙ Automatically check for updates"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo "∙ Download newly available updates in the background"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true

echo "∙ Install app updates"
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

echo "∙ Install macOS updates"
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true

echo "∙ Install system data files and security updates"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
