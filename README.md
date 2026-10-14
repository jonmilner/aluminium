# 💻 Aluminium

Sets up a Mac, or re-syncs one, with a single script.

## New Mac

1. Sign in to iCloud (with iCloud Drive on).
2. Open Terminal and run:

   ```sh
   curl -fsSL https://raw.githubusercontent.com/jonmilner/aluminium/main/bootstrap | bash
   ```

   This installs the Command Line Tools, clones the repo to `~/aluminium` (or `$ALUMINIUM_DIR`), and runs `bootstrap`.
3. Work through the checklist it prints at the end.

## Existing Mac

```sh
cd ~/aluminium && git pull && ./bootstrap
```

### First run on an existing Mac

`bootstrap` moves your current `~/.zshrc` and other dotfiles to `*.backup-<date>` files. Once the new shell works, these are safe to remove:

```sh
rm -rf ~/.oh-my-zsh ~/.zsh/pure ~/Library/pnpm ~/aluminium/dotfiles
brew uninstall fnm
```

### Steps

Run single steps by name, e.g. `./bootstrap links ssh`. Steps: `xcode`, `homebrew`, `packages`, `vite`, `links`, `ssh`, `secrets`, `macos`, `checklist`. `macos` only runs when named, until its scripts are refreshed.

## Layout

| Path | What |
|---|---|
| `Brewfile` | CLI tools and apps for every Mac. Add machine-specific ones to `Brewfile.local` (untracked). |
| `home/` | Linked into `~` (see `LINKS` in `bootstrap`). |
| `config/` | Linked into `~/.config`. |
| `zsh/` | Loaded by `zshrc`. |
| `macos/` | `defaults` scripts. |

Secrets live in `iCloud Drive/dotfiles/secrets.zsh`, never in this repo. `zshrc` loads it if present.

---

## Acknowledgements

- [Formation](https://github.com/minamarkham/formation) by Mina Markham.
