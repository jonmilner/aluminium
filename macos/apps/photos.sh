#!/bin/bash

###############################################################################
echo "Photos"
###############################################################################

echo "∙ Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
