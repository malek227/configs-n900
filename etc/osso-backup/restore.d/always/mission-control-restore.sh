#!/bin/sh

# Script to be run after restoring backup data

RESTORE_LIST="$1"
grep rtcom-accounts "$RESTORE_LIST" || exit 0

ACCOUNTSDIR=/home/user/.rtcom-accounts
BACKUPDIR="/tmp/.rtcom-accounts"

/etc/init.d/mission-control.sh stop
rm -rf "$ACCOUNTSDIR"
mv "$BACKUPDIR" "$ACCOUNTSDIR"
sync
dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus \
org.freedesktop.DBus.StartServiceByName \
string:org.freedesktop.Telepathy.MissionControl5 uint32:0 > /dev/null

