#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Set Preferences
###############################################################################

PREF_FILES=$HOME/dotfiles/macos/

# System Preferences
source $PREF_FILES/system/dashboard.sh
source $PREF_FILES/system/date-time.sh
source $PREF_FILES/system/displays.sh
source $PREF_FILES/system/dock.sh
source $PREF_FILES/system/finder.sh
source $PREF_FILES/system/general.sh
source $PREF_FILES/system/hot-corners.sh
source $PREF_FILES/system/keyboard.sh
source $PREF_FILES/system/language-region.sh
source $PREF_FILES/system/mission-control.sh
source $PREF_FILES/system/notifications.sh
source $PREF_FILES/system/other.sh
source $PREF_FILES/system/printers-scanners.sh
source $PREF_FILES/system/screenshots.sh
source $PREF_FILES/system/security-privacy.sh
source $PREF_FILES/system/sound.sh
source $PREF_FILES/system/time-machine.sh
source $PREF_FILES/system/trackpad.sh
source $PREF_FILES/system/users-groups.sh

# Application Preferences
source $PREF_FILES/apps/activity-monitor.sh
source $PREF_FILES/apps/app-store.sh
source $PREF_FILES/apps/google-chrome.sh
source $PREF_FILES/apps/iwork.sh
source $PREF_FILES/apps/safari.sh

###############################################################################
# Clean Up
###############################################################################

# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
  esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
  echo "Rebooting."
  sudo reboot
  exit 0
else
  exit 1
fi
