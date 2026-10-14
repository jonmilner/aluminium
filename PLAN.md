# Aluminium cleanup plan

Goal: clone this repo on a new Mac, run one script, and have very little manual setup left. Re-running the same script keeps existing Macs in sync.

## Decisions

| Topic | Decision |
|---|---|
| Packages | One `Brewfile` (formulae, casks, Mac App Store apps via `mas`, VS Code extensions), applied with `brew bundle`. |
| Setup script | A single idempotent `bootstrap`. No per-item prompts. Safe to re-run. |
| Symlinks | A short manifest inside `bootstrap` (repo path to home path). Back up anything already there, then link. No stow or chezmoi. |
| Shell | No oh-my-zsh. Homebrew installs `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zoxide`, `fzf` and `pure`. About 20 lines of plain zsh replace what oh-my-zsh set. |
| Node | Vite+. Drop `fnm`. |
| Secrets | `secrets.zsh` in iCloud Drive (`~/Library/Mobile Documents/com~apple~CloudDocs/dotfiles/secrets.zsh`), loaded by `zshrc` if present. Never in the repo. Only end-to-end encrypted if Advanced Data Protection is on. |
| SSH | A separate ed25519 key per machine, passphrase stored in Keychain, uploaded with `gh ssh-key add`. Not synced. |
| Machine-specific settings | Untracked `~/.zshrc.local`. |
| Repo location | Path-independent. Nothing hardcodes `~/aluminium`. |

## Phases

### 0. Save current state
- [x] Commit pending local changes.
- [x] Bring the live `~/.zshrc` (pnpm, Vite+, `flatten-movies`) into the repo. Ghostty was already there.
- [x] Record the real inventory in a draft `Brewfile`.

Findings:
- Raycast keeps no settings in `~/.config`. Use its built-in export/import (manual step).
- VS Code Settings Sync already covers its settings and extensions, so they stay out of the Brewfile.

### 1. Restructure
- New layout: `Brewfile`, `home/` (files linked into `~`), `config/` (files linked into `~/.config`), `macos/`, `bootstrap`.
- Delete `install/*`, `functions`, `hyper.js` and `z.sh`. Keep `npmrc`: it reads `NPM_TOKEN_JONMILNER` from the environment, which `secrets.zsh` sets.
- Remove all Dropbox references (app list, Dock, `private.zsh` line). Screenshots now go to `iCloud Drive/Screenshots`.
- Prune the Brewfile to what belongs on every machine. Machine-specific apps go in `Brewfile.local` (untracked).

### 2. Bootstrap script
In order, each step skipped if already done:
1. Xcode Command Line Tools: install, then wait until finished.
2. Homebrew, then `eval "$(/opt/homebrew/bin/brew shellenv)"`.
3. `brew bundle` (plus `Brewfile.local` if present).
4. Symlinks from the manifest, with timestamped backups.
5. SSH key and `gh auth login`.
6. Secrets: if `secrets.zsh` is in iCloud Drive but not downloaded yet, fetch it with `brctl download`. If it's missing, warn and carry on.
7. macOS defaults, then restart Dock, Finder and SystemUIServer.
8. Print the remaining manual checklist.

Fresh machine entry point: a `curl | bash` one-liner that clones the repo and runs `bootstrap`.

### 3. Shell and dev tooling
- Rewrite `zshrc` without oh-my-zsh. Keep `~/.zshrc` as a stub that sources the repo, so installers that append to it don't break the link.
- Vite+ only: remove `fnm` and the `chpwd` hook. Check whether Vite+ switches Node per project from `.nvmrc`. Pick one pnpm (remove `PNPM_HOME` or Vite+'s copy).
- Fix `gitconfig`: install the diff pager it uses (or switch to `delta`), add `git-lfs` to the Brewfile, drop the missing `~/.gitattributes`, move the global ignore to `~/.config/git/ignore`.
- Set `EDITOR="code --wait"`.

### 4. Refresh macOS defaults
- Check every key against macOS 26 and remove dead ones (Dashboard hot corner, `AppleFontSmoothing`, `QLEnableTextSelection`, `EmptyTrashSecurely`, Safari keys that are now sandboxed, "System Preferences" references).
- Rebuild the Dock with `dockutil` from a list of apps that are actually installed.
- Drop the Simulator symlink unless full Xcode is in the Brewfile.

### 5. Remaining manual steps
A short README checklist of what can't be automated. Before running `bootstrap`: sign in to iCloud (with iCloud Drive on) and the App Store. After: 1Password/Passwords sign-in, Full Disk Access and Accessibility permissions, app licenses, Raycast settings import.

### 6. Prevent drift
- `bootstrap --check`: report unlinked or modified files and Brewfile differences without changing anything.
- ShellCheck in a pre-commit hook or GitHub Action.

## Known bugs in the current scripts
Fixed by the rewrite. Listed so none come back:
- Homebrew PATH assumes Intel (`/usr/local`).
- `xcode-select --install` isn't awaited.
- `[ -x nvm ]` and `[ -x mas ]` test for files in the current folder, not commands.
- `check_internet_connection` never pings.
- `open "~/../Applications/..."`: the tilde isn't expanded inside quotes.
- The macOS defaults step is gated on `install/open` existing.
- Relative symlink targets only work when the repo is at `~/aluminium`.
