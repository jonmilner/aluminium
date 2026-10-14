#!/bin/bash

###############################################################################
echo "Mission Control"
###############################################################################

echo "∙ Automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false
