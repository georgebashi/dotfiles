#!/bin/sh

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDoubleTapGesture -int 0
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

defaults write com.apple.dock "expose-group-by-app" -bool false
defaults write com.apple.dock "dashboard-in-overlay" -bool true

# nuke stupid resume thing
rm -r $HOME/Library/Saved\ Application\ State
chmod -R a-w $HOME/Library/Saved\ Application\ State
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# tab over all ui elements
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write -g com.apple.keyboard.fnState -int 1

# font smoothing
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# don't warn when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# dock on left
defaults write com.apple.dock orientation -string left

# show battery time in menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# set clock format
defaults write com.apple.menuextra.clock DateFormat -string "h:mm"

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# disable "are you sure you want to open this app?" warning
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true

# Don't write .DS_Store files on network vols
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# enable airdrop over ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# show full path in finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# disable resume
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

defaults write com.apple.addressbook ABShowDebugMenu -bool true
defaults write com.apple.iCal IncludeDebugMenu -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true

defaults write com.apple.finder QLEnableTextSelection -bool true

# Reset Launchpad
rm ~/Library/Application\ Support/Dock/*.db

# Kill affected applications
for app in Safari Finder Dock; do killall "$app"; done
