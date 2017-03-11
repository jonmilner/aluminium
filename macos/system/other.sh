#!/bin/bash

###############################################################################
echo "Other"
###############################################################################

echo "∙ Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "∙ Opening and closing speed of Quick Look windows"
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

echo "∙ Opening and closing window animations"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "∙ Disable animated focus ring"
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

echo "∙ Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "∙ Disable Resume system-wide"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

echo "∙ Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "∙ Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"
