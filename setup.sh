#!/usr/bin/env bash

# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

###############################################################################
# Symlinks
###############################################################################

# Atom
ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom

# Git
ln -s dotfiles/git/gitattributes ~/.gitattributes
ln -s dotfiles/git/gitconfig ~/.gitconfig
ln -s dotfiles/git/gitignore ~/.gitignore

# Hyper
ln -s dotfiles/hyper/hyper.js ~/.hyper.js

# zsh
ln -s dotfiles/zsh/zshrc ~/.zshrc
