#!/bin/bash

###############################################################################
echo "Mission Control"
###############################################################################

echo "∙ Mission Control animation duration"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "∙ Automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false
