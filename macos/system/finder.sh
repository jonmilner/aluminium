#!/bin/bash

###############################################################################
echo "Finder"
###############################################################################

echo "∙ Show user 'Library' folder"
chflags nohidden ~/Library/

echo "∙ Quit via ⌘ + Q"
defaults write com.apple.finder QuitMenuItem -bool true

echo "∙ Show icons for hard drives, servers, and removable media on desktop"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "∙ Show hidden files"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "∙ Show filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "∙ Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "∙ Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "∙ Show full POSIX path as window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "∙ Set search scope to current folder"
# This Mac: `SCev`, Current Folder: `SCcf`, Previous Scope: `SCsp`
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "∙ Disable file extension change warning"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "∙ Enable spring loaded directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "∙ Set shortest delay for spring loaded directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo "∙ Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "∙ Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "∙ Open folders in column view, grouped by Kind and sorted by Name"
# View: Icon `icnv`, List `Nlsv`, Column `clmv`, Gallery `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string clmv
# Group by: Kind, Name, Application, Date Last Opened,
# Date Added, Date Modified, Date Created, Size, Tags, None
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"

echo "∙ Sidebar: hide Recent Tags"
defaults write com.apple.finder ShowRecentTags -bool false

echo "∙ Sidebar icon size"
# Small  : 1
# Medium : 2
# Large  : 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "∙ New window target"
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget -string 'PfHm'
#defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "∙ Warning before emptying Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "∙ Remove all tags from contextual menu"
# /usr/libexec/PlistBuddy -c "Delete :FavoriteTagNames" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Add :FavoriteTagNames array" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Add :FavoriteTagNames:0 string" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Expand File Info panes"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

# Nested settings. Edit an exported copy and import it, rather than editing the
# plist in place, which cfprefsd can overwrite. This comes after every
# `defaults write` above, because the import replaces the whole domain.
finder_plist=$(mktemp)
defaults export com.apple.finder "$finder_plist" 2>/dev/null || plutil -create xml1 "$finder_plist"

# pb_set <Key:Nested:Path> <type> <value>
# Creates missing parent dicts, which a new Mac doesn't have yet.
pb_set() {
  local key=$1 type=$2 value=$3 parent= part parts
  /usr/libexec/PlistBuddy -c "Set \":$key\" $value" "$finder_plist" 2>/dev/null && return
  IFS=: read -r -a parts <<<"$key"
  for part in "${parts[@]:0:${#parts[@]}-1}"; do
    parent+=":$part"
    /usr/libexec/PlistBuddy -c "Add \"$parent\" dict" "$finder_plist" 2>/dev/null
  done
  /usr/libexec/PlistBuddy -c "Add \":$key\" $type $value" "$finder_plist"
}

echo "∙ Desktop: item info to the right of small icons, arranged by Kind"
pb_set DesktopViewSettings:IconViewSettings:showItemInfo bool true
pb_set DesktopViewSettings:IconViewSettings:labelOnBottom bool false
pb_set DesktopViewSettings:IconViewSettings:arrangeBy string kind
pb_set DesktopViewSettings:IconViewSettings:gridSpacing real 100
pb_set DesktopViewSettings:IconViewSettings:iconSize real 32
pb_set DesktopViewSettings:IconViewSettings:textSize real 10

echo "∙ Icon view options"
# ArrangeBy (Sort by): dnam Name, kipl Kind, ludt Date Last Opened,
# pAdd Date Added, modd Date Modified, ascd Date Created, logs Size, labl Tags
pb_set StandardViewSettings:IconViewSettings:textSize real 11
pb_set StandardViewSettings:IconViewSettings:showItemInfo bool true
pb_set StandardViewSettings:IconViewSettings:arrangeBy string kipl

echo "∙ Sidebar width"
pb_set SidebarWidth integer 192

echo "∙ Toolbar: small icons only"
# Display mode: 1 Icon and Text, 2 Icon Only, 3 Text Only
/usr/libexec/PlistBuddy -c 'Delete "NSToolbar Configuration Browser"' "$finder_plist" 2>/dev/null
pb_set "NSToolbar Configuration Browser:TB Display Mode" integer 2
pb_set "NSToolbar Configuration Browser:TB Icon Size Mode" integer 1
pb_set "NSToolbar Configuration Browser:TB Is Shown" integer 1
pb_set "NSToolbar Configuration Browser:TB Size Mode" integer 1

defaults import com.apple.finder "$finder_plist"
rm -f "$finder_plist"

# screenshots.sh runs after this file, so create its folder now for the sidebar
# and the view below.
mkdir -p "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"

echo "∙ Sidebar favorites and locations"
/usr/bin/python3 -I "$dir/lib/finder-sidebar.py"

# Per-folder views. Finder remembers each folder's last view, and treats a view
# change in any window as the new default for all folders. So: forget the
# remembered views, set the exceptions, then set the defaults again. The first
# run asks to let the terminal control Finder. The reset reads Desktop, Documents
# and Downloads, which without Full Disk Access stops for permission prompts.
echo "∙ Forget per-folder views Finder remembered"
if "$dir/lib/has-full-disk-access"; then
  "$dir/lib/finder-reset.sh"
else
  echo "  ! Skipped: needs Full Disk Access for this terminal"
fi

# finder_view <folder> column
# finder_view <folder> list <name|modified> <normal|reversed>
finder_view() {
  [[ -d $1 ]] || return 0
  osascript - "$1" "$2" "${3:-name}" "${4:-normal}" >/dev/null 2>&1 <<'APPLESCRIPT' || echo "  ! Couldn't set the view for $1. Allow this terminal to control Finder (System Settings → Privacy & Security → Automation), then run: ./bootstrap macos"
on run {folderPath, viewName, sortBy, direction}
  with timeout of 60 seconds
    tell application "Finder"
      set f to (POSIX file folderPath) as alias
      open f
      -- Finder may have just relaunched: wait until the front window is this folder.
      repeat 20 times
        delay 0.5
        try
          if (target of Finder window 1 as alias) as text is f as text then exit repeat
        end try
      end repeat
      set w to Finder window 1
      if (target of w as alias) as text is not f as text then error "window didn't open"
      if viewName is "column" then
        set current view of w to column view
      else
        set current view of w to list view
        set opts to list view options of w
        if sortBy is "modified" then
          set sort column of opts to modification date column
          set c to column id modification date column of opts
        else
          set sort column of opts to name column
          set c to column id name column of opts
        end if
        if direction is "reversed" then
          set sort direction of c to reversed
        else
          set sort direction of c to normal
        end if
      end if
      close w
    end tell
  end timeout
end run
APPLESCRIPT
}

echo "∙ Downloads: column view (macOS defaults it to list view)"
finder_view "$HOME/Downloads" column

echo "∙ Screenshots: list view, newest first"
finder_view "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Screenshots" list modified reversed

echo "∙ Applications: list view, by name"
finder_view /Applications list name normal

echo "∙ Default view again (the views above changed it)"
defaults write com.apple.finder FXPreferredViewStyle -string clmv
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
