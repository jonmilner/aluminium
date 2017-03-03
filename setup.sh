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
create_symlink dotfiles/atom/ ~/.atom

# Git
create_symlink dotfiles/git/gitattributes ~/.gitattributes
create_symlink dotfiles/git/gitconfig ~/.gitconfig
create_symlink dotfiles/git/gitignore ~/.gitignore

# Hyper
create_symlink dotfiles/hyper/hyper.js ~/.hyper.js

# zsh
create_symlink dotfiles/zsh/zshrc ~/.zshrc
