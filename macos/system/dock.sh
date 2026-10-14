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

# Add the apps that Brewfile (and Brewfile.local) installed, if the Dock doesn't
# already have them. Never removes or reorders anything. Menu bar utilities and
# apps that are only opened from files stay out.
dock_skip=" bartender raycast vlc "
echo "∙ Add Brewfile apps missing from the Dock"
docked=$(dockutil --list --no-restart 2>/dev/null | cut -f5)
for brewfile in "$dir/../Brewfile" "$dir/../Brewfile.local"; do
  [[ -f $brewfile ]] || continue
  for cask in $(brew bundle list --cask --file="$brewfile"); do
    [[ $dock_skip == *" $cask "* ]] && continue
    app=$(brew info --cask --json=v2 "$cask" |
      jq -r '.casks[0].artifacts[] | .app? // empty | if (.[1] | type) == "object" then .[1].target else .[0] end' | head -1)
    path="/Applications/$app"
    [[ -n $app && -d $path ]] || continue
    id=$(defaults read "$path/Contents/Info" CFBundleIdentifier 2>/dev/null)
    grep -qxF "$id" <<<"$docked" && continue
    dockutil --add "$path" --no-restart >/dev/null && echo "  added $app"
  done
done
