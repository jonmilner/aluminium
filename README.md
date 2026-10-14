# 💻 Aluminium

Sets up a Mac, or re-syncs one, with a single script.

## New Mac

### Before you start

- Finish macOS Setup Assistant and sign in with your Apple Account. This turns on iCloud Drive, which holds your secrets file.
- Use an administrator account. The account Setup Assistant creates is one; `bootstrap` stops early if yours isn't.

### Run it

Open **Terminal** and run:

```sh
curl -fsSL https://raw.githubusercontent.com/jonmilner/aluminium/main/bootstrap | bash
```

You'll be asked for two things, both in the first minute:

1. **Your Mac password**, once. It installs the Command Line Tools and Homebrew.
2. **GitHub sign-in.** Press Enter, then approve the one-time code in your browser. This uploads the new Mac's SSH key and lets the script clone private repos.

After that it runs unattended: apps and tools, Vite+, dotfile links and secrets. It clones this repo to `~/aluminium` (set `$ALUMINIUM_DIR` to change that). If macOS asks whether Terminal may access iCloud Drive, allow it.

### After it finishes

`bootstrap` prints this list at the end:

<!-- checklist:start -->
- [ ] Quit Terminal and use Ghostty from now on.
- [ ] Sign in to 1Password, Chrome, Claude and GitHub Desktop.
- [ ] VS Code: turn on Settings Sync (Accounts menu, bottom left) to restore settings and extensions.
- [ ] Raycast: import settings (Settings → Advanced → Import).
- [ ] Raycast and Bartender: grant Accessibility (and Screen Recording for Bartender) when they ask.
- [ ] Bartender: enter your license.
- [ ] First Mac only: create `iCloud Drive/dotfiles/secrets.zsh` with your tokens as `export` lines (e.g. `NPM_TOKEN_JONMILNER`).
<!-- checklist:end -->

## Existing Mac

```sh
cd ~/aluminium && git pull && ./bootstrap
```

### One-time setup on an existing Mac

- **App Management permission.** `bootstrap` can't take over apps you installed by hand until your terminal is allowed to modify apps. Turn on your terminal (e.g. Ghostty) in System Settings → Privacy & Security → App Management, quit and reopen it, then run `./bootstrap packages`. `bootstrap` checks for this and opens the setting if it's off. Homebrew also needs this permission later to update apps.
- **Old files.** The first run moves your current `~/.zshrc` and other dotfiles to `*.backup-<date>` files. Once the new shell works, these are safe to remove, along with tools Aluminium no longer uses:

  ```sh
  rm -rf ~/.oh-my-zsh ~/.zsh/pure ~/Library/pnpm ~/aluminium/dotfiles
  brew uninstall fnm
  ```

### Steps

Run single steps by name, e.g. `./bootstrap links github`. Steps, in order: `xcode`, `homebrew`, `github`, `packages`, `vite`, `links`, `secrets`, `macos`, `checklist`. `macos` only runs when named, until its scripts are refreshed.

## Testing

`scripts/test-vm [version]` opens a fresh macOS VM with copy and paste to and from this Mac (needs [Tart](https://tart.run); the first run downloads a ~28 GB image). Paste the `curl` command above into Terminal in the VM (it's logged in as `admin`, password `admin`). Closing the VM window or pressing Ctrl-C deletes the VM; `scripts/test-vm --clean` removes one left behind. To test a branch before it merges, put the branch name in the URL in place of `main` and pipe to `ALUMINIUM_REF=<branch> bash`. Automated tests are planned in [docs/plans/automated-testing.md](docs/plans/automated-testing.md).

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
