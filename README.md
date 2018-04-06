# dotfiles

## Install Xcode
- Open Terminal
- Run `git`
- Click **Get Xcode**

## Install Updates
```shell
sudo softwareupdate -ia --verbose
```

## Clone Repo
```shell
git clone https://github.com/jonmilner/dotfiles.git ~/dotfiles
```

## Apps & Settings

### Homebrew
```shell
sh dotfiles/install/brew.sh
```

### Sign In to Dropbox
```shell
open ../../Applications/Dropbox.app
```

Go to Preferences > Account > Selective Sync to prioritize download order.

### Mackup
Once DropBox is set up, use Mackup to restore Application settings.

```shell
mackup restore
```

### Applications Setup
```shell
sh dotfiles/install/openApps.sh
```

## Development Tools

### ZSH
```shell
sh dotfiles/install/zsh.sh
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
sh dotfiles/install/npm.sh
```

### Symlinks
```shell
sh dotfiles/setup.sh
```

### zsh-syntax-highlighting
```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Launching Visual Studio Code from the Command Line
Open the Command Palette (⇧⌘P) and type 'shell command' to find the **Shell Command: Install 'code' command in PATH** command.

## macOS Settings
```shell
sh dotfiles/macos/set-defaults.sh
```

## Additional Setup

### Mission Control Mouse Setup
![Mission Control Mouse Setup](mission-control-mouse-setup.png)
