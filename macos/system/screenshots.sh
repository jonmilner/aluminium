#!/bin/bash

###############################################################################
echo "Screenshots"
###############################################################################

echo "∙ Screenshot location"
screenshots="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"
mkdir -p "$screenshots"
defaults write com.apple.screencapture location -string "$screenshots"

echo "∙ Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "∙ Shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "∙ Include date in screenshots"
defaults write com.apple.screencapture include-date -bool true
