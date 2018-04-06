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
brew install diff-so-fancy
brew install mackup
brew install mas
brew install yarn

# Install Cask
brew tap caskroom/cask

# Install GUI Applications
brew cask install adobe-creative-cloud
brew cask install appcleaner
brew cask install clipy
brew cask install dropbox
brew cask install firefox
brew cask install github-desktop
brew cask install google-chrome
brew cask install handbrake
brew cask install hyper
brew cask install scroll-reverser
brew cask install sketch
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install the-unarchiver
brew cask install transmission
brew cask install transmit
brew cask install virtualbox
brew cask install vlc
brew cask install visual-studio-code

# Install Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-json
brew cask install webpquicklook

# Install Screen Savers
brew cask install aerial

# Install Mac App Store apps
mas install 443987910 # 1Password
mas install 413857545 # Divvy
mas install 668208984 # GIPHY Capture
mas install 403388357 # Gitbox
mas install 731062389 # iFlicks 2
mas install 409183694 # iWork - Keynote
mas install 409203825 # iWork - Numbers
mas install 409201541 # iWork - Pages
mas install 972028355 # Micro Snitch
mas install 497799835 # Xcode

# Remove outdated versions from the cellar
brew cleanup && brew prune
