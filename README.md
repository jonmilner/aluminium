# dotfiles

## Install Updates
`sudo softwareupdate -ia --verbose`

## Clone
`git clone https://github.com/jonmilner/dotfiles.git ~/dotfiles`

## Install

### ZSH
`sh dotfiles/install/zsh.sh`

### NVM
`curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash`

### Homebrew
`sh dotfiles/install/brew.sh`

### Install GUI Applications, Plugins & Screen Savers
`sh dotfiles/install/cask.sh`

### Node
`sh dotfiles/install/npm.sh`

### OSX defaults
`sh dotfiles/macos/set-defaults.sh`

### Symlinks
`sh dotfiles/setup.sh`

## Other Stuff

### zsh-syntax-highlighting
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
