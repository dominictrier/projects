#!/bin/sh

# Pipe all Output into Log File
exec >> /log.txt 2>&1

# Prepare Files & Folders and Move into Place
mkdir /Users/Shared/wallpaper
mkdir /Users/Shared/screensaver
cd /Users/Shared/
mv /initial_tmp/gsd_background.jpg /Users/Shared/wallpaper/
mv /initial_tmp/gsd_screensaver.jpg /Users/Shared/screensaver/
mv /initial_tmp/kcpassword /etc/
chown -R -v staff:staff wallpaper/ screensaver/
chmod 755 -R screensaver/ wallpaper/
cd /

# Setup Dock
/usr/local/bin/dockutil --remove all /Users/staff/
/usr/local/bin/dockutil --add /Applications/Mail.app /Users/staff/
/usr/local/bin/dockutil --add /Applications/TextEdit.app /Users/staff/
/usr/local/bin/dockutil --add /Applications/Managed\ Software\ Center.app /Users/staff/

# Set GSD Wallpaper (Image provided by pkgfile)
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/Shared/wallpaper/gsd_background.jpg"'


# Setup Screensaver
# Define macUUID variable for next Step
if [ "$(ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-50)" != "00000000-0000-1000-8000-" ]; then
    macUUID="$(ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-62)"
fi

# Set Screensaver & Screensaver Lock (Images Provided by pkgfile)
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist CleanExit "YES"
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist PrefsVersion 100
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist idleTime 600
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist moduleDict -dict path "/System/Library/Frameworks/ScreenSaver.framework/Resources/iLifeSlideshows.saver" moduleName "iLifeSlideshows" type 0
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist showClock 1
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist tokenRemovalAction 0
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.ScreenSaver.iLifeSlideShows.$macUUID.plist styleKey "KenBurns"
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist CustomFolderDict -dict identifier "/Users/Shared/screensaver/" name "screensaver"
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist LastViewedPhotoPath ""
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedFolderPath "/Users/Shared/screensaver"
defaults write /Users/staff/Library/Preferences/ByHost/com.apple.ScreenSaverPhotoChooser.$macUUID.plist SelectedSource 4
defaults write /Users/staff/Library/Preferences/com.apple.screensaver.plist askForPassword 0

# Provide Access back to Staff & Limit File Permissions to Staff to Mirror other plist Files
cd /Users/staff/Library/Preferences/ByHost/
chown staff:staff com.apple.ScreenSaverPhotoChooser.$macUUID.plist com.apple.ScreenSaver.iLifeSlideShows.$macUUID.plist com.apple.screensaver.$macUUID.plist
chmod 600 com.apple.ScreenSaver.iLifeSlideShows.$macUUID.plist com.apple.ScreenSaverPhotoChooser.$macUUID.plist com.apple.screensaver.$macUUID.plist
cd /Users/staff/Library/Preferences/
chown staff:staff com.apple.screensaver.plist
chmod 600 com.apple.screensaver.plist
cd /

# Force Core Foundation Preferences to Reload
killall cfprefsd

# Set Auto Login Users (essential /etc/kcpassword provided by pkgfile)
defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser "staff"

# Network Setup
/usr/sbin/networksetup -createlocation gsd_ethernet
/usr/sbin/networksetup -switchtolocation gsd_ethernet
/usr/sbin/networksetup -deletelocation Automatic
/usr/sbin/networksetup -createnetworkservice Ethernet Ethernet
# optional
/usr/sbin/networksetup -setdhcp Ethernet

# Add all Users to Printer Admin
/usr/sbin/dseditgroup -o edit -n /Local/Default -a staff -t group lpadmin

exit 0
