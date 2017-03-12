#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install Packages
brew install mackup
brew install mas

# Install Cask
brew tap caskroom/cask

# Install GUI Applications
brew cask install --force appcleaner
brew cask install --force atom
brew cask install --force clipmenu
brew cask install --force dropbox
brew cask install --force firefox
brew cask install --force github-desktop
brew cask install --force google-chrome
brew cask install --force handbrake
brew cask install --force hyper
brew cask install --force sketch
brew cask install --force slack
brew cask install --force spotify
brew cask install --force transmit

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

# Install Mac App Store apps
mas install 443987910 # 1Password
mas install 413857545 # Divvy
mas install 403388357 # Gitbox
mas install 409183694 # iWork - Keynote
mas install 409203825 # iWork - Numbers
mas install 409201541 # iWork - Pages
mas install 497799835 # Xcode

# Remove outdated versions from the cellar
brew cleanup && brew prune
