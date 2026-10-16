#!/bin/bash

###############################################################################
echo "Safari"
###############################################################################

# Safari is sandboxed: it reads its settings from its container, not from
# ~/Library/Preferences. Writing there needs Full Disk Access for the terminal.
safari="$HOME/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari"
# shellcheck disable=SC2154 # dir is set by set-defaults.sh, which sources this file
if ! "$dir/lib/has-full-disk-access"; then
  echo "  ! Skipped: needs Full Disk Access for this terminal"
  return 0
elif [[ ! -d ${safari%/*} ]]; then
  echo "  ! Skipped: open Safari once first"
  return 0
fi
# Safari overwrites its settings on quit, so close it first.
osascript -e 'quit app "Safari"' 2>/dev/null

echo "∙ Hide Safari's bookmark bar."
defaults write "$safari" ShowFavoritesBar -bool false

echo "∙ Set up Safari for development."
defaults write "$safari" IncludeInternalDebugMenu -bool true
defaults write "$safari" IncludeDevelopMenu -bool true
defaults write "$safari" WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write "$safari" "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true

echo "∙ Privacy: don’t send search queries to Apple"
defaults write "$safari" UniversalSearchEnabled -bool false
defaults write "$safari" SuppressSearchSuggestions -bool true

echo "∙ Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write "$safari" AutoOpenSafeDownloads -bool false

echo "∙ Set Safari’s home page to 'about:blank' for faster loading"
defaults write "$safari" HomePage -string "about:blank"

echo "∙ Show the full URL in the address bar (note: this still hides the scheme)"
defaults write "$safari" ShowFullURLInSmartSearchField -bool true

echo "∙ Disable AutoFill"
defaults write "$safari" AutoFillFromAddressBook -bool false
defaults write "$safari" AutoFillPasswords -bool false
defaults write "$safari" AutoFillCreditCardData -bool false
defaults write "$safari" AutoFillMiscellaneousForms -bool false

echo "∙ Warn about fraudulent websites"
defaults write "$safari" WarnAboutFraudulentWebsites -bool true

echo "∙ Block pop-up windows"
defaults write "$safari" WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write "$safari" com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
