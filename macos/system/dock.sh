#!/bin/bash

###############################################################################
echo "Dock"
###############################################################################

echo "∙ Set icon size"
defaults write com.apple.dock tilesize -int 32

echo "∙ Lock the Dock size"
defaults write com.apple.dock size-immutable -bool true

echo "∙ Auto-hide the Dock"
defaults write com.apple.dock autohide -bool true

echo "∙ Don't show recent applications in Dock"
defaults write com.apple.dock show-recents -bool FALSE

echo "∙ Minimize windows into their app icon, with the scale effect"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string scale

echo "∙ Fade hidden applications"
defaults write com.apple.dock showhidden -bool true

# Once per Mac, remove the apps macOS puts in the Dock, except these. The list
# comes from the Dock's own resources (current and older macOS), so it covers
# whatever this Mac started with. Later runs leave the Dock's apps alone, so an
# app you put back stays. Delete the marker file to run it again.
dock_keep=" com.apple.finder com.apple.Safari com.apple.MobileSMS com.apple.Photos com.apple.systempreferences "
dock_marker="$HOME/.local/state/aluminium/dock-cleaned"
if [[ ! -e $dock_marker ]] && ! command -v dockutil >/dev/null; then
  echo "  ! Dock cleanup skipped: dockutil isn't installed yet. Run: ./bootstrap packages macos"
elif [[ ! -e $dock_marker ]]; then
  echo "∙ Remove macOS default apps from the Dock (first run on this Mac)"
  dock_res=/System/Library/CoreServices/Dock.app/Contents/Resources
  docked=$(dockutil --list --no-restart 2>/dev/null | cut -f5)
  {
    for f in "$dock_res"/default{,-old}.plist "$dock_res"/com.apple.dockfixup{,-old}.plist; do
      plutil -p "$f" 2>/dev/null | sed -n 's/.*"_CFURLString" => "\(.*\.app\)\/*"$/\1/p' |
        while IFS= read -r path; do defaults read "$path/Contents/Info" CFBundleIdentifier 2>/dev/null; done
      plutil -p "$f" 2>/dev/null | sed -n 's/.*"bundle-identifier" => "\(.*\)"$/\1/p'
    done
  } | sort -u | while IFS= read -r id; do
    [[ $dock_keep == *" $id "* ]] && continue
    grep -qxF "$id" <<<"$docked" || continue
    dockutil --remove "$id" --no-restart >/dev/null && echo "  removed $id"
  done
  mkdir -p "${dock_marker%/*}" && touch "$dock_marker"
fi

# Add the apps that Brewfile (and Brewfile.local) installed, if the Dock doesn't
# already have them. Never removes or reorders anything. Menu bar utilities and
# apps that are only opened from files stay out.
dock_skip=" bartender raycast vlc "
echo "∙ Add Brewfile apps missing from the Dock"
docked=$(dockutil --list --no-restart 2>/dev/null | cut -f5)
casks=()
for brewfile in "$dir/../Brewfile" "$dir/../Brewfile.local"; do
  [[ -f $brewfile ]] || continue
  for cask in $(brew bundle list --cask --file="$brewfile"); do
    [[ $dock_skip == *" $cask "* ]] || casks+=("$cask")
  done
done
# One brew call for every cask: each call takes a second or two.
if (( ${#casks[@]} )); then
  brew info --cask --json=v2 "${casks[@]}" |
    jq -r '.casks[] | first(.artifacts[] | .app? // empty | if (.[1] | type) == "object" then .[1].target else .[0] end)' |
    while IFS= read -r app; do
      path="/Applications/$app"
      [[ -d $path ]] || continue
      id=$(defaults read "$path/Contents/Info" CFBundleIdentifier 2>/dev/null)
      grep -qxF "$id" <<<"$docked" && continue
      dockutil --add "$path" --no-restart >/dev/null && echo "  added $app"
    done
fi
