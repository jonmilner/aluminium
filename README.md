# 💻 Aluminium

> Being rewritten. See [PLAN.md](PLAN.md); the steps below are out of date.

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

### 3. 👨‍💻 Sign into App Store

This needs to be done manually prior to running the script.

### 4. ⬇️ Download Aluminium

```sh
git clone https://github.com/jonmilner/aluminium.git ~/aluminium && cd aluminium
```

### 5. 💾 Run the Script

```sh
sh aluminium
```

### 6. 🎨 Install zsh-syntax-highlighting

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 7. ⌨️ Open VSCode from Command Line with `code .`

Open the Command Palette (⇧⌘P) and type `shell command` to find the **Shell Command: Install 'code' command in PATH** command.

---

## Acknowledgements

- [Formation](https://github.com/minamarkham/formation) by Mina Markham.
