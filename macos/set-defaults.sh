#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Set Preferences
###############################################################################

PREF_FILES=$HOME/aluminium/macos/

# Application Preferences
source $HOME/aluminium/macos/apps/activity-monitor.sh
source $HOME/aluminium/macos/apps/app-store.sh
source $HOME/aluminium/macos/apps/google-chrome.sh
source $HOME/aluminium/macos/apps/iwork.sh
source $HOME/aluminium/macos/apps/safari.sh

# System Preferences
source $HOME/aluminium/macos/system/dashboard.sh
source $HOME/aluminium/macos/system/date-time.sh
source $HOME/aluminium/macos/system/displays.sh
source $HOME/aluminium/macos/system/dock.sh
source $HOME/aluminium/macos/system/finder.sh
source $HOME/aluminium/macos/system/general.sh
source $HOME/aluminium/macos/system/hot-corners.sh
source $HOME/aluminium/macos/system/keyboard.sh
source $HOME/aluminium/macos/system/language-region.sh
source $HOME/aluminium/macos/system/mission-control.sh
source $HOME/aluminium/macos/system/other.sh
source $HOME/aluminium/macos/system/printers-scanners.sh
source $HOME/aluminium/macos/system/screenshots.sh
source $HOME/aluminium/macos/system/security-privacy.sh
source $HOME/aluminium/macos/system/sound.sh
source $HOME/aluminium/macos/system/time-machine.sh
source $HOME/aluminium/macos/system/trackpad.sh
source $HOME/aluminium/macos/system/users-groups.sh
