#!/bin/bash

###############################################################################
echo "Safari"
###############################################################################

echo "∙ Hide Safari's bookmark bar."
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "∙ Set up Safari for development."
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true

echo "∙ Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "∙ Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "∙ Set Safari’s home page to 'about:blank' for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "∙ Show the full URL in the address bar (note: this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "∙ Disable AutoFill"
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

echo "∙ Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

echo "∙ Disable plug-ins"
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

echo "∙ Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

echo "∙ Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

echo "∙ Enable “Do Not Track”"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "∙ Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
