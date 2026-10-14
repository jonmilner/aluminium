#!/bin/bash

###############################################################################
echo "Menu Bar"
###############################################################################

echo "∙ Show Control Center and Battery (with percentage)"
defaults write com.apple.controlcenter "NSStatusItem VisibleCC BentoBox-0" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Battery" -bool true
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

echo "∙ Hide Wi-Fi, Sound, Bluetooth, Focus and Now Playing (they're in Control Center)"
for item in WiFi Sound Bluetooth FocusModes NowPlaying; do
  defaults write com.apple.controlcenter "NSStatusItem VisibleCC $item" -bool false
done
# Fast User Switching is left at the macOS default.
