#!/bin/bash
# Forget the views Finder remembered for folders in your home folder, so every
# folder uses the defaults from macos/system/finder.sh. Finder records each
# folder's last view in its parent's .DS_Store and has no setting to stop it.
# ~/Library is left alone. Run macos/system/finder.sh afterwards (or
# ./bootstrap macos) to set the per-folder exceptions and defaults again.
# Skips ~/Library, hidden folders and node_modules, which Finder rarely shows
# and which are slow to walk. Not -delete: it implies -depth, which makes find
# ignore -prune.
find "$HOME" \( -path "$HOME/Library" -o -name node_modules -o \( -name '.?*' -type d \) \) -prune \
  -o -name .DS_Store -type f -exec rm -f {} +
# Finder saves the views it has in memory when it quits, which would write the
# old records straight back, so force-quit it. launchd relaunches it.
killall -KILL Finder 2>/dev/null || true
for _ in 1 2 3 4 5 6 7 8 9 10; do pgrep -x Finder >/dev/null && break; sleep 1; done
