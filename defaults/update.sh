#!/usr/bin/env bash
set -e

# Hide dock automatically
defaults write com.apple.dock autohide -bool true

# Empty the applications persistently shown in Dock
defaults write com.apple.dock persistent-apps -array

# Remove Downloads folder from Dock
defaults write com.apple.dock persistent-others -array

# Reboot Dock to reflect the changes of com.apple.dock
killall Dock

# Enable full-keyboard-access (allowing tab-key to focus on all things)
defaults write -g AppleKeyboardUIMode -int 3

# Allow access to system preferences from iTerm
sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db \
  "INSERT OR REPLACE INTO access VALUES('kTCCServiceAccessibility','com.googlecode.iterm2',0,1,0,NULL);"

# Use function keys as normal
# Note: only GUI can force the change without reboot
osascript <<< '
tell application "System Preferences"
    reveal anchor "keyboardTab" of pane "com.apple.preference.keyboard"
end tell
tell application "System Events" to tell process "System Preferences"
    set functionStateCheckbox to checkbox 1 of tab group 1 of window 1
    tell functionStateCheckbox
        if not (its value as boolean) then click functionStateCheckbox
    end tell
end tell
quit application "System Preferences"
'
