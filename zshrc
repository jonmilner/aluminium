# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Custom folder
ZSH_CUSTOM=$HOME/dotfiles/zsh

# Load zsh modules
autoload -U compinit promptinit
compinit # Initialize completion
promptinit # Initialize prompt

# Pure Prompt
prompt pure

# Plugins
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Defaults
export EDITOR=atom

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Aliases
alias c="clear"
alias ll="ls -lFh"
alias la="ls -lAFh"  # List all files (inlcuding hidden)

# nvm
export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

# yarn
export PATH="$HOME/.yarn/bin:$PATH"
