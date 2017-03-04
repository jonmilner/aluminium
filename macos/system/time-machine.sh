#!/bin/bash

###############################################################################
echo "Time Machine"
###############################################################################

echo "∙ Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
