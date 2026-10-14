# Plan: automated testing

Status: proposed, not started. Written to be picked up by another agent. Claims marked *(unverified)* haven't been checked yet; check them before building on them.

## Goal

One command, run from an established Mac, that:

1. installs what it needs (Tart and a macOS image),
2. boots a clean macOS VM of a chosen version,
3. runs `bootstrap` the way a new Mac would,
4. checks the result with a test suite,
5. reports pass/fail, keeps the logs, and deletes the VM.

Choosing the macOS version lets the user test a new major release before upgrading their real Macs.

```sh
scripts/test                      # unit tests only (fast, no VM)
scripts/test e2e                  # VM test against the current macOS release
scripts/test e2e --macos 26.6.2   # a specific version
scripts/test e2e --local          # test the working tree, not a pushed branch
scripts/test e2e --ref my-branch  # test a pushed branch through the curl path
scripts/test e2e --keep --gui     # keep the VM and show its screen, for debugging
```

## What exists today

- `bootstrap` (bash 3.2) with named steps. It has been tested by hand in a throwaway `$HOME` and in one partial run on a real Mac.
- Tart 2.41.0 is installed on the user's main Mac at `~/Applications/tart.app`, with the `tart` command linked in `~/.local/bin`. It came from the GitHub release, because the `cirruslabs/cli/tart` Homebrew formula fails on Homebrew 7 (`depends_on macos:` is rejected).
- Clean macOS images: `ghcr.io/cirruslabs/macos-<codename>-vanilla:<version>`. Tags seen on 2026-10-14: tahoe `26.2` … `26.6.2`, sequoia `15.5` … `15.7.7`.

## Facts that shape the design

- **No `tart exec` on vanilla images.** It needs the Tart Guest Agent, which only the non-vanilla images include, and those come with Homebrew and other tools preinstalled, so they aren't "fresh". The harness has to use **SSH**. Vanilla images log in as `admin` / `admin`, with SSH on and password login allowed (checked 2026-10-14 on 26.6.2: boots without a window in about 7 s, port 22 open about 5 s later).
- **Password for SSH:** use `SSH_ASKPASS` with `SSH_ASKPASS_REQUIRE=force` to install a key once, then use key auth. `bootstrap`'s `new_ssh_key` already uses this trick. `expect` ships with macOS as a fallback.
- **Sharing the working tree:** `tart run --dir name:path[:ro]` exposes a host folder to the guest, so `--local` can test uncommitted changes. The guest path is likely `/Volumes/My Shared Files/<name>` *(unverified)*.
- **No screen:** `tart run --no-graphics`, then `tart ip <vm> --wait 120`.
- **Clones are cheap:** `tart clone` is a copy-on-write copy of the pulled image, so a fresh VM per run costs seconds. Each image is about 25–50 GB on disk, downloaded once per version.
- **Concurrency:** macOS allows at most 2 macOS VMs at once per host *(unverified for macOS 26)*, so run versions one after another.
- **Unreleased macOS:** check whether Cirrus Labs publishes beta images. If not, `tart create --from-ipsw <url>` builds a VM from Apple's installer, but that VM still needs Setup Assistant clicked through, which Cirrus Labs automates with Packer in `cirruslabs/macos-image-templates`. Apple's Virtualization framework may not run a guest newer than the host *(unverified)*, which could limit testing a new major release before upgrading. Check this first, since it decides whether the "test before upgrading" goal is reachable.

## Changes `bootstrap` needs first

1. **`ALUMINIUM_REF`:** in `curl` mode, clone that branch (`git clone --branch`) so a branch can be tested before it merges: `curl …/aluminium/<ref>/bootstrap | ALUMINIUM_REF=<ref> bash`.
2. **Unattended mode** (`ALUMINIUM_NONINTERACTIVE=1`): never prompt. The `github` step uses `GH_TOKEN` if set and otherwise skips with a warning. `need_sudo` uses `sudo -n` and fails clearly if that doesn't work.
3. **Machine-readable result:** if `ALUMINIUM_REPORT=<file>` is set, write one line per warning there, so the harness doesn't parse coloured output.
4. **Keychain over SSH:** `ssh-add --apple-use-keychain` may fail in an SSH session because the login keychain is locked *(unverified)*. The harness can run `security unlock-keychain -p admin` first. `bootstrap` itself shouldn't need to change for this.

## Test layers

### 1. Unit tests: `test/unit.sh` (seconds, no VM)

Automate the checks that were done by hand:

- `/bin/bash -n bootstrap` (stock bash 3.2) and `zsh -n` on every zsh file.
- ShellCheck on `bootstrap` and `macos/*.sh` (install it to a temp folder if missing, so nothing else is added to the Brewfile).
- **`links` in a throwaway `$HOME`:** creates links, backs up existing files, a second run changes nothing, and retired links are removed.
- **`secrets`** without iCloud warns and doesn't fail.
- **Arguments:** unknown steps are rejected, and `checklist` prints the README's list.
- **Admin check:** with a fake `id` that drops the `admin` group, the default run and the `curl` run stop before any step, and `links` still runs.
- **`brew_writable`:** a read-only Cellar warns.
- **`new_ssh_key`** with a throwaway key: encrypted on disk, loaded with no prompt (agent only, then removed).
- **`zshrc`** loads in an isolated `ZDOTDIR` with nothing on stderr.

### 2. End-to-end: `test/e2e.sh` (about 15–30 min per macOS version)

On the host:

1. Make sure Tart is installed. If not, download the release, check its checksum and that it's notarized (`spctl -a -t exec`), then install it to `~/Applications`.
2. `tart pull` the image for `--macos` (map `15` to sequoia and `26` to tahoe, with `--image` for anything else).
3. `tart clone <image> aluminium-test-<timestamp>`, then `tart run --no-graphics` (plus `--dir` for `--local`), then wait for the IP and SSH.
4. Install an SSH key, give `admin` passwordless sudo through `/etc/sudoers.d/` (stands in for the password prompt), and unlock the keychain.
5. Run `bootstrap` over SSH: either the `curl` command with `ALUMINIUM_REF`, or `./bootstrap` from the shared folder. Pass `ALUMINIUM_NONINTERACTIVE=1` and `ALUMINIUM_REPORT`. Save all output to `test/logs/<timestamp>/` (gitignored).
6. Run `test/assert.sh` inside the VM, then **run `bootstrap` a second time** and assert it changed nothing.
7. Copy the logs out, `tart stop`, and `tart delete` (unless `--keep`). Exit non-zero on any failure.

`test/assert.sh` (inside the VM, prints `ok` / `not ok` lines):

- `bootstrap` exited 0, and its report contains only expected warnings (e.g. no `secrets.zsh`, no iCloud in a VM).
- `brew bundle check --file=Brewfile` passes, and every cask's app is in `/Applications`.
- Every `LINKS` entry is a symlink to the matching repo file.
- `zsh -i -c exit` prints nothing on stderr. Pure, zoxide and fzf load, and `EDITOR` is `code --wait`.
- `node` and `pnpm` resolve to Vite+, and a folder with `.nvmrc` containing `20` resolves Node 20.
- `git config core.editor` and `git config pull.rebase` match `home/gitconfig`, and git reads `~/.config/git/ignore`.
- The second run: exit 0, no new `*.backup-*` files, no warnings beyond the first run's.
- Later: `macos` defaults read back as set (once phase 4 adds `macos` to the default run); `agents` checks (phase 7).

### 3. Optional scenarios (flags)

- **`--with-github`:** pass `GH_TOKEN` into the VM so the `github` step runs for real: key upload, `ssh -T git@github.com`, remote switched to SSH. Teardown deletes the VM's key from GitHub using its title. Needs a token with the `admin:public_key` scope. **Open question:** the user's own account (a key is added and removed each run) or a separate test account?
- **`--existing-mac`:** before running `bootstrap`, seed the VM with a hand-installed app (e.g. copy VLC from its disk image), an old `~/.zshrc` and an old `~/.gitconfig`. Then assert adoption, backups and the App Management message. Over SSH the process macOS checks for App Management is `sshd`, not Terminal, so results may differ from a real terminal *(unverified)*.

### 4. CI (later, optional)

A GitHub Actions workflow on a macOS runner runs `test/unit.sh` on every PR. GitHub's Apple Silicon runners don't support running a VM inside them, and their images come with Homebrew and Xcode preinstalled, so the end-to-end test stays local.

## Suggested order

1. Check the *(unverified)* facts above, starting with the ones about unreleased macOS.
2. Add the `bootstrap` changes (`ALUMINIUM_REF`, unattended mode, report file).
3. `test/unit.sh` and the `scripts/test` entry point.
4. `test/e2e.sh` and `test/assert.sh` for the current release, `--local` and `--ref`.
5. `--macos` version selection and a two-version run (e.g. 15 and 26).
6. `--existing-mac`, then `--with-github`.
7. CI for the unit tests.
8. README "Testing" section.

## Done when

- `scripts/test` (unit) runs in under a minute and covers everything listed above.
- `scripts/test e2e --macos <version>` goes from nothing to a pass/fail result with no interaction, on both the current release and the previous one.
- A failure leaves logs that point at the step and the check that failed.
- The README documents how to test a new macOS release before upgrading, including any limits found in step 1.
