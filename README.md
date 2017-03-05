# dotfiles

## Install Updates
`sudo softwareupdate -ia --verbose`

## Clone
`git clone https://github.com/jonmilner/dotfiles.git ~/dotfiles`

## Install

### Fix Permissions
`sudo chown -R "$USER":admin /usr/local`

### ZSH
`sh dotfiles/install/zsh.sh`

#### zsh-syntax-highlighting
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

### Homebrew
`sh dotfiles/install/brew.sh`

### Node
`sh dotfiles/install/npm.sh`

### OSX defaults
`sh dotfiles/macos/set-defaults.sh`

### Symlinks
`sh dotfiles/setup.sh`
