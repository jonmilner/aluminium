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

# Get the dotfiles directory's absolute path
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Symlink and report creation of link
create_symlink() {
  ln -sfn $1 $2
  echo "Symlinked ${1} -> ${2}"
}

###############################################################################
# Symlinks
###############################################################################

# Atom
ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom
create_symlink $DOTFILES_DIR/atom/ ~/.atom

# Git
create_symlink $DOTFILES_DIR/git/gitattributes ~/.gitattributes
create_symlink $DOTFILES_DIR/git/gitconfig ~/.gitconfig
create_symlink $DOTFILES_DIR/git/gitignore ~/.gitignore

# Hyper
create_symlink $DOTFILES_DIR/hyper/hyper.js ~/.hyper.js

# zsh
create_symlink $DOTFILES_DIR/zsh/zshrc ~/.zshrc
