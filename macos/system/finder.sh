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

echo "∙ Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

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

echo "∙ Set icon view settings on desktop and in icon views"

echo "∙ Desktop - Item info near icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Desktop - Item info to right of icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Desktop - Arrange icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Desktop - Grid spacing for icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Desktop - Icon size"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 32" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Desktop - Text size"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 10" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Arrange by Kind"
# Kind, Name, Application, Date Last Opened,
# Date Added, Date Modified, Date Created, Size, Tags, None
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"

echo "∙ View Options"
# ColumnShowIcons    : Show preview column
# ShowPreview        : Show icons
# ShowIconThumbnails : Show icon preview
# ArrangeBy          : Sort by
#   dnam : Name
#   kipl : Kind
#   ludt : Date Last Opened
#   pAdd : Date Added
#   modd : Date Modified
#   ascd : Date Created
#   logs : Size
#   labl : Tags
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:columnShowIcons false" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:textSize 11" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy kipl" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Sidebar icon size"
# Small  : 1
# Medium : 2
# Large  : 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "∙ Set Sidebar Width"
/usr/libexec/PlistBuddy -c "Set :SidebarWidth 192" ~/Library/Preferences/com.apple.finder.plist

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

echo "∙ Empty Trash securely"
defaults write com.apple.finder EmptyTrashSecurely -bool false

echo "∙ Set the finder window toolbar to only have back/forward buttons"
/usr/libexec/PlistBuddy -c "Delete :NSToolbar\ Configuration\ Browser:TB\ Item\ Identifiers" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :NSToolbar\ Configuration\ Browser:TB\ Item\ Identifiers array" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :NSToolbar\ Configuration\ Browser:TB\ Item\ Identifiers:1 string com.apple.finder.BACK" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Remove all tags from contextual menu"
# /usr/libexec/PlistBuddy -c "Delete :FavoriteTagNames" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Add :FavoriteTagNames array" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Add :FavoriteTagNames:0 string" ~/Library/Preferences/com.apple.finder.plist

echo "∙ Expand File Info panes"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

echo "∙ Customize Finder Window Toolbar"
# 1 for Icon and Text, 2 for Icon Only, 3 for Text Only
/usr/libexec/PlistBuddy -c 'Delete "NSToolbar Configuration Browser" dict' > /dev/null 2>&1 ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Display Mode" integer 2' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Icon Size Mode" integer 1' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Is Shown" integer 1' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:0" string "com.apple.finder.BACK"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:1" string "com.apple.finder.CNCT"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:3" string "com.apple.finder.ACTN"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:9" string "com.apple.finder.EJCT"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:7" string "com.apple.finder.INFO"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:4" string "com.apple.finder.LABL"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:5" string "NSToolbarSpaceItem"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:6" string "NSToolbarFlexibleSpaceItem"' ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Item Identifiers:8" string "com.apple.finder.SRCH"' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Add "NSToolbar Configuration Browser:TB Size Mode" integer 1' ~/Library/Preferences/com.apple.finder.plist
