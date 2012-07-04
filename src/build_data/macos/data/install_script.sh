#!/bin/bash

# uninstall old
if test -d /usr/libexec/brickd.app
then
	launchctl unload com.tinkerforge.brickd
	rm /System/Library/LaunchDaemons/com.tinkerforge.brickd.plist
	rm -rf /usr/libexec/brickd.app
fi

# install new
cd $1
cp com.tinkerforge.brickd.plist /System/Library/LaunchDaemons/
cp -r brickd.app /usr/libexec/
launchctl load /System/Library/LaunchDaemons/com.tinkerforge.brickd.plist
launchctl start com.tinkerforge.brickd
