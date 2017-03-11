#!/bin/bash

###############################################################################
echo "Notifications"
###############################################################################

echo "∙ Disable Notification Center and remove the menu bar icon"
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
