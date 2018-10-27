# dotfiles

### Clone Repo
```shell
git clone https://github.com/jonmilner/dotfiles.git ~/dotfiles
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

### ZSH
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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

### macOS Settings
```shell
sh dotfiles/macos/set-defaults.sh
```

### Mission Control Mouse Setup
![Mission Control Mouse Setup](mission-control-mouse-setup.png)


### Set ForkLift as default Finder
```shell
defaults write -g NSFileViewer -string com.binarynights.ForkLift-3
```