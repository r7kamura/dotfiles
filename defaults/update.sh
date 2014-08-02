#!/usr/bin/env bash
set -e

# Hide dock automatically
defaults write com.apple.dock autohide -bool true

# Empty the applications persistently shown in Dock
defaults write com.apple.dock persistent-apps -array

# Remove Downloads folder from Dock
defaults write com.apple.dock persistent-others -array

# Use function keys as normal
defaults write -g com.apple.keyboard.fnState -bool true

# Enable full-keyboard-access (allowing tab-key to focus on all things)
defaults write -g AppleKeyboardUIMode -int 3

# Reboot Dock to reflect the changes of com.apple.dock
killall Dock
