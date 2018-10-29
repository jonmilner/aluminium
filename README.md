# 💻 Aluminium

Aluminium is a shell script to set up a new macOS environment.

## Reinstall macOS (Optional)

Reboot into **Recovery Mode** by holding the Command (⌘) and R keys until the Apple logo appears on the screen.

## Run Aluminium

The following steps should be run in order.

### 1. 🗜 Install Xcode

- Open Terminal
- Run `git`
- Click **Get Xcode**

### 2. 🧟‍ Install zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 3. 🎨 Install zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 4. 👨‍💻 Sign into App Store

This needs to be done manually prior to running the script.

### 5. ⬇️ Download Aluminium
```sh
git clone https://github.com/jonmilner/aluminium.git ~/aluminium && cd aluminium
```

### 6. 💾 Run the Script
```sh
sh aluminium
```

### 7. 📦 Configure Dropbox
Once setup, go to Preferences > Account > Selective Sync to prioritize download order for Mackup.

### 8. ⏮ Mackup
Use Mackup to restore Application settings from Dropbox.

```sh
mackup restore
```

### 9. 🤫 Add `zsh/private.zsh`
Copy `private.zsh` to `~/aluminium/dotfiles/zsh`

### 10. ⌨️ Open VSCode from Command Line with `code .`
Open the Command Palette (⇧⌘P) and type `shell command` to find the **Shell Command: Install 'code' command in PATH** command.

### 11. 🖱 Add Mission Control to External Mouse Buttons

![Mission Control Mouse Setup](assets/mission-control-mouse-setup.png)

---

## Acknowledgements

- [Formation](https://github.com/minamarkham/formation) by Mina Markham.
