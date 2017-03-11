#!/bin/bash

###############################################################################
echo "Keyboard"
###############################################################################

echo "∙ Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "∙ Set key repeat rate (minimum 1)"
# Off: 300000
# Slow: 120
# Fast: 2
defaults write NSGlobalDomain KeyRepeat -int 2

echo "∙ Set delay until repeat (in milliseconds)"
# Long: 120
# Short: 15
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "∙ Use smart quotes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "∙ Use smart dashes"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
