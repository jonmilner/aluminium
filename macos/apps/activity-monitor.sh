#!/bin/bash

###############################################################################
echo "Activity Monitor"
###############################################################################

echo "∙ Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5
