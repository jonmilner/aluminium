#!/bin/bash

###############################################################################
echo "Users & Groups"
###############################################################################

echo "∙ Display login window as: Name and password"
sudo defaults write /Library/Preferences/com.apple.loginwindow "SHOWFULLNAME" -bool true

echo "∙ Disable automatic login"
sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null

echo "∙ Allow guests to login to this computer"
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

echo "∙ Show password hints after count (0 to disable)"
defaults write NSGlobalDomain RetriesUntilHint -int 0
