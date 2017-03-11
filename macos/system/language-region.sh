#!/bin/bash

###############################################################################
echo "Language & Region"
###############################################################################

echo "∙ Prefered languages (in order of preference)"
defaults write NSGlobalDomain AppleLanguages -array "en"

echo "∙ Currency"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"

echo "∙ Measure Units"
# `Inches` or `Centimeters`
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"

#echo "∙ Force 12/24 hour time"
#defaults write NSGlobalDomain AppleICUForce12HourTime -bool true

echo "∙ Set Metric Units"
defaults write NSGlobalDomain AppleMetricUnits -bool false
