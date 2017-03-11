# dotfiles

## Clone
```shell
git clone https://github.com/jonmilner/dotfiles.git ~/dotfiles
```

## Install

### Install Updates
```shell
sudo softwareupdate -ia --verbose
```

### Fix Permissions
```shell
sudo chown -R "$USER":admin /usr/local
```

### ZSH
```shell
sh dotfiles/install/zsh.sh
```

#### zsh-syntax-highlighting
```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Homebrew
```shell
sh dotfiles/install/brew.sh
```

### NVM
```shell
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
```

### Node
```shell
nvm install stable
nvm use node
nvm alias default node
sh dotfiles/install/npm.sh```

### OSX defaults
```shell
sh dotfiles/macos/set-defaults.sh
```

### Symlinks
```shell
sh dotfiles/setup.sh
```

## Additional Setup

### Mission Control Mouse Setup
![Mission Control Mouse Setup](mission-control-mouse-setup.png)
