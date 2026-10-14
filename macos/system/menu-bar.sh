#!/bin/bash

###############################################################################
echo "Menu Bar"
###############################################################################

# Control Center reads these per-module values from the current-host domain.
# (The "NSStatusItem VisibleCC" keys in com.apple.controlcenter are a cache that
# Control Center overwrites on launch.) 18: menu bar and Control Center,
# 24: Control Center only.

echo "∙ Show Battery, with percentage"
defaults -currentHost write com.apple.controlcenter Battery -int 18
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

echo "∙ Hide Wi-Fi, Sound, Bluetooth, Focus and Now Playing (they're in Control Center)"
for item in WiFi Sound Bluetooth FocusModes NowPlaying; do
  defaults -currentHost write com.apple.controlcenter "$item" -int 24
done
# Fast User Switching is left at the macOS default.

echo "∙ Hide Spotlight (Raycast replaces it)"
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool true
