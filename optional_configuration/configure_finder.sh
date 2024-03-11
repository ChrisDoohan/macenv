#!/bin/bash
set -e

source ./shared/common_functions.sh

log_initialize "CONFIGURING FINDER FILE OPTIONS..."

# Show all file extensions all the time
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable "Show warning before changing an extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# New Finder windows should open in the user's home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Restart Finder
killall Finder

log_success "FINDER FILE OPTIONS CONFIGURED."
