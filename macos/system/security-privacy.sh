#!/bin/bash

###############################################################################
echo "Security & Privacy"
###############################################################################

echo "∙ Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 5

echo "∙ Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "∙ Touch ID for sudo"
# sudo_local survives macOS updates, unlike /etc/pam.d/sudo.
# Keeps any lines already there, such as pam_reattach, which must come first.
if [[ ! -f /etc/pam.d/sudo_local ]]; then
  sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null
elif ! grep -q '^[[:space:]]*auth.*pam_tid.so' /etc/pam.d/sudo_local; then
  echo 'auth       sufficient     pam_tid.so' | sudo tee -a /etc/pam.d/sudo_local >/dev/null
fi

echo "∙ Turn on the firewall, with stealth mode"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on >/dev/null
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on >/dev/null
