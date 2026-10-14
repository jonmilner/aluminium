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

echo "∙ Turn off Spotlight's ⌘Space shortcut (Raycast uses it)"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

echo "∙ Turn off autocorrect, auto-capitalisation and double-space period"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
