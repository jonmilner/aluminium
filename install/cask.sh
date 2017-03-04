#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Cask
brew tap caskroom/cask

# Install GUI Applications
brew cask install --force 1password
brew cask install --force atom
brew cask install --force clipmenu
brew cask install --force divvy
brew cask install --force dropbox
brew cask install --force firefox
brew cask install --force gitbox
brew cask install --force github-desktop
brew cask install --force google-chrome
brew cask install --force hyper
brew cask install --force sketch
brew cask install --force slack
brew cask install --force spotify

# Install Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install --force qlcolorcode
brew cask install --force qlimagesize
brew cask install --force qlmarkdown
brew cask install --force qlstephen
brew cask install --force qlvideo
brew cask install --force quicklook-json
brew cask install --force webpquicklook

# Install Screen Savers
brew cask install --force aerial
brew cask install --force ios-lockscreen

# Remove outdated versions from the cellar
brew cask cleanup