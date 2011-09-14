# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilte-stack -bool true

# Enable spring loading for all Dock items
defaults write enable-spring-load-actions-on-all-items -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Speed up keyboard repeat
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeDebugMenu -bool true

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Disable send and reply animations in Mail.app
defaults write com.apple.Mail DisableReplyAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true

# Disable Resume for Preview, TextEdit, QuickTime
# defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false
# defaults write com.apple.TextEdit NSQuitAlwaysKeepsWindows -bool false
# defaults write com.apple.QuicktimePlayerX NSQuitAlwaysKeepsWindows -bool false

# Reset Launchpad
rm ~/Library/Application\ Support/Dock/*.db

# Show the ~/Library folder
chflags nohidden ~/Library

# Show POSIX Path in Finder Window Title
defaults write com.apple.finder _FXShowPosixPathInTitle YES

# Show Path Bar in Finder
defaults write com.apple.finder ShowPathBar -boolean YES

# Make hidden applications transparent
defaults write com.apple.Dock showhidden -bool true

# show folder previews in quicklook
defaults write com.apple.finder QLEnableXRayFolders 1

# speedup spaces animation as far as it is possible (only works if you switch by number)
defaults write com.apple.dock workspaces-edge-delay -float 0.1
defaults write com.apple.dock expose-animation-duration -int 0

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
echo "0x08000100:0" > ~/.CFUserTextEncoding

# Kill affected applications
for app in Safari Finder Dock Mail; do killall "$app"; done


