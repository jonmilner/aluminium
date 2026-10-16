#!/bin/bash

###############################################################################
echo "Desktop & Window Management"
###############################################################################

echo "∙ Clicking the wallpaper doesn't reveal the desktop (only in Stage Manager)"
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

echo "∙ No margins between tiled windows"
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

echo "∙ Show widgets on the desktop"
defaults write com.apple.WindowManager StandardHideWidgets -bool false
