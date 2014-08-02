#!/usr/bin/env bash
set -e

defaults write com.apple.dock autohide -bool true

# Empty the applications persistently shown in Dock
defaults write com.apple.dock persistent-apps -array

# Reboot Dock to reflect the changes
killall Dock
