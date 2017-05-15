#!/bin/bash

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
ln -sfn /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom

# bin
ln -sfn dotfiles/bin ~/bin

# Git
ln -sfn dotfiles/git/gitattributes ~/.gitattributes
ln -sfn dotfiles/git/gitconfig ~/.gitconfig
ln -sfn dotfiles/git/gitignore ~/.gitignore

# Hyper
ln -sfn dotfiles/hyper/hyper.js ~/.hyper.js

# Mackup
ln -sfn dotfiles/mackup/mackup.cfg ~/.mackup.cfg

# Tmux
ln -sfn dotfiles/.tmux.conf ~/.tmux.conf

# zsh
ln -sfn dotfiles/zsh/zshrc ~/.zshrc
