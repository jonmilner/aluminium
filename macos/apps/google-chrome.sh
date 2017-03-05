#!/bin/bash

###############################################################################
echo "Google Chrome"
###############################################################################

echo "∙ Make Google Chrome the default browser"
open -a "Google Chrome" --args --make-default-browser

echo "∙ Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

echo "∙ Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
