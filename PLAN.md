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
- [x] New layout: `Brewfile`, `home/` (files linked into `~`), `config/` (files linked into `~/.config`), `zsh/` (files `zshrc` sources), `macos/`.
- [x] Delete `install/*`, `functions`, `aluminium`, `hyper.js` and `z.sh`. Keep `npmrc`: it reads `NPM_TOKEN_JONMILNER` from the environment, which `secrets.zsh` sets.
- [x] Remove all Dropbox references. Screenshots go to `iCloud Drive/Screenshots`; `zshrc` loads secrets from iCloud Drive.
- [x] No hardcoded `~/aluminium`: `zshrc` finds the repo from its own symlink, and `set-defaults.sh` from its own location.
- [x] Prune the Brewfile to what belongs on every machine. Machine-specific apps go in `Brewfile.local` (untracked).

The live `~/.gitconfig` and Ghostty symlinks, and the live `~/.zshrc`, still point at the old paths. After merging, run `./bootstrap` once to re-link everything.

### 2. Bootstrap script
- [x] `bootstrap`: named steps, each skipped if already done. Runs on stock bash 3.2. Default order: `xcode`, `homebrew`, `packages`, `vite` (before `links`, so its `~/.zshrc` edit lands in the backed-up file), `links`, `ssh`, `secrets`, `checklist`.
- [x] `ssh`: per-machine ed25519 key in Keychain, `gh auth login`, key uploaded to GitHub, GitHub host keys from its API, repo remote switched to SSH.
- [x] `macos` exists but only runs when named, until phase 4.
- [x] `curl | bash` entry point: installs Command Line Tools, clones, re-runs from the clone.
- [x] README rewritten around `bootstrap`.
- Tested in a throwaway `$HOME`: `links` (backups, re-run), `secrets`, unknown steps, `curl` mode. Not yet run for real: `homebrew`, `packages`, `vite`, `ssh`, `macos`.

Ready to merge after phase 3. See "First run on an existing Mac" in the README.

### 3. Shell and dev tooling
- [x] `zshrc` rewritten without oh-my-zsh: Homebrew `shellenv`, Vite+, completion (case-insensitive, menu), Up/Down history search, Pure, zoxide, fzf, autosuggestions, syntax highlighting. Loads `zsh/history.zsh`, `aliases.zsh`, `functions.zsh` (`flatten-movies`), secrets from iCloud Drive, then `~/.zshrc.local`.
- [x] `~/.zshrc` links straight to the repo instead of a stub: any installer that appends to it shows up in `git diff`, and `bootstrap` re-links if one replaces the file.
- [x] Vite+ only. It resolves Node from `.nvmrc` per project, so the fnm hook is gone. `PNPM_HOME` dropped (it held only a spare pnpm, no global packages).
- [x] `gitconfig`: removed the missing `~/.gitattributes`, the diff-so-fancy pager and the LFS filter. The global ignore moved to `~/.config/git/ignore`, which git reads by default. `bootstrap` removes the old `~/.gitignore` link.
- [x] `EDITOR="code --wait"`. `gst` uses `git stash push` (`stash save` is deprecated).
- Tested in a throwaway `$HOME`: the shell loads with no errors other than Pure, which isn't installed via Homebrew yet. Pure loads once it's on `fpath`.

### 4. Refresh macOS defaults
- Check every key against macOS 26 and remove dead ones (Dashboard hot corner, `AppleFontSmoothing`, `QLEnableTextSelection`, `EmptyTrashSecurely`, Safari keys that are now sandboxed, "System Preferences" references).
- Rebuild the Dock with `dockutil` from a list of apps that are actually installed.
- Drop the Simulator symlink unless full Xcode is in the Brewfile.

### 5. New-Mac experience and manual steps
Target: finish Setup Assistant, open Terminal, paste one command, answer two prompts in the first minute, walk away.
- [x] Command Line Tools install silently via `softwareupdate` (GUI dialog only as a fallback).
- [x] SSH key gets a random passphrase stored straight in Keychain. No passphrase prompt.
- [x] `github` step (was `ssh`) runs before `packages`, installs `gh` itself, and asks for the key-upload scope at sign-in, so there's one browser approval, not two.
- [x] `packages` checks App Management permission before adopting hand-installed apps (existing Macs only).
- [x] Every manual step is in the README (before, during, after, existing-Mac only). `bootstrap` prints the "after" checklist from the README, so there's one copy.
- [ ] Verify on a fresh Mac or a new macOS user account: the `softwareupdate` label parsing, whether the Vite+ installer still prompts with `VP_NODE_MANAGER=yes`, and whether macOS asks before Terminal touches iCloud Drive.
- [ ] Phase 4 adds any permissions the defaults scripts need (e.g. Full Disk Access for Terminal) to the README.
- [ ] Optional: Touch ID for `sudo` (`/etc/pam.d/sudo_local`), so the password prompt becomes a fingerprint on later runs.

### 6. Prevent drift
- `bootstrap --check`: report unlinked or modified files and Brewfile differences without changing anything.
- ShellCheck in a pre-commit hook or GitHub Action.

### 7. Agents: Claude Code and jonai
Goal: a new Mac comes out of `bootstrap` with Claude Code and the jonai skills, agents, hooks and instructions installed, with no extra commands.

Proposed `agents` step, after `github` (jonai is private, so cloning needs the SSH key) and `secrets`:
1. Install Claude Code with its native installer if `claude` is missing (matches this Mac: `~/.local/bin/claude`, which updates itself).
2. Clone `jonmilner/jonai` to `~/git/jonai` over SSH if it isn't there.
3. Link `~/.config/jonai` (jonai's local layer: personal `AGENTS.md` and `denylist`) to `iCloud Drive/dotfiles/jonai`. This must happen before step 4, or `link.sh` creates a fresh layer from `local.example`.
4. Run `~/git/jonai/scripts/link.sh` from the main checkout. This also fixes this Mac's `~/.claude/CLAUDE.md`, which imports from the `jonai-wt-ui-authoring` worktree and breaks if that worktree is deleted.
5. README checklist: sign in to Claude Code on first run.

Open questions:
- Where the jonai local layer lives. Recommended: iCloud Drive, so it syncs and stays private. It can't go in this public repo, because `denylist` is a list of private terms (names, emails, project names). Leaving it per-machine means editing it by hand on every Mac.
- `~/.claude/settings.json` (model, plugins, marketplaces, hooks) isn't managed by either repo, and jonai's hooks each need a manual `settings.json` edit. Proposal: jonai owns it (a change in jonai, not here). Check first whether Claude Code replaces a symlinked `settings.json` when it saves.
- Codex: `~/.codex` exists but `codex` isn't installed. Skip unless wanted.
- Optional: clone your other projects into `~/git` from a list.

## Known bugs in the current scripts
Fixed by the rewrite. Listed so none come back:
- Homebrew PATH assumes Intel (`/usr/local`).
- `xcode-select --install` isn't awaited.
- `[ -x nvm ]` and `[ -x mas ]` test for files in the current folder, not commands.
- `check_internet_connection` never pings.
- `open "~/../Applications/..."`: the tilde isn't expanded inside quotes.
- The macOS defaults step is gated on `install/open` existing.
- Relative symlink targets only work when the repo is at `~/aluminium`.
