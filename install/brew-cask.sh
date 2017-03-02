#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Install Caskroom
brew tap caskroom/cask

# Install packages
apps=(
  1password
  atom
  clipmenu
  divvy
  dropbox
  firefox
  gitbox
  github-desktop
  google-chrome
  hyper
  sketch
  slack
  spotify
)

brew cask install "${apps[@]}"

# Install Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
quicklookplugins=(
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlstephen
  qlvideo
  quicklook-json
  webpquicklook
)

brew cask install "${quicklookplugins[@]}"
