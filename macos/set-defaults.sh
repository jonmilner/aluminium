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

# Application Preferences
source $HOME/dotfiles/macos/apps/activity-monitor.sh
source $HOME/dotfiles/macos/apps/app-store.sh
source $HOME/dotfiles/macos/apps/google-chrome.sh
source $HOME/dotfiles/macos/apps/iwork.sh
source $HOME/dotfiles/macos/apps/safari.sh

# System Preferences
source $HOME/dotfiles/macos/system/dashboard.sh
source $HOME/dotfiles/macos/system/date-time.sh
source $HOME/dotfiles/macos/system/displays.sh
source $HOME/dotfiles/macos/system/dock.sh
source $HOME/dotfiles/macos/system/finder.sh
source $HOME/dotfiles/macos/system/general.sh
source $HOME/dotfiles/macos/system/hot-corners.sh
source $HOME/dotfiles/macos/system/keyboard.sh
source $HOME/dotfiles/macos/system/language-region.sh
source $HOME/dotfiles/macos/system/mission-control.sh
source $HOME/dotfiles/macos/system/other.sh
source $HOME/dotfiles/macos/system/printers-scanners.sh
source $HOME/dotfiles/macos/system/screenshots.sh
source $HOME/dotfiles/macos/system/security-privacy.sh
source $HOME/dotfiles/macos/system/sound.sh
source $HOME/dotfiles/macos/system/time-machine.sh
source $HOME/dotfiles/macos/system/trackpad.sh
source $HOME/dotfiles/macos/system/users-groups.sh

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
