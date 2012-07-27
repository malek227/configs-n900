#!/bin/sh

echo "$*" | grep -q "comm_and_cal" || exit 0

# Copy to a temporary location so that restore script can
# manually move them to the original one and restart
# the applications using it.

ACCOUNTSDIR=/home/user/.rtcom-accounts
BACKUPDIR=/tmp/.rtcom-accounts

rm -rf "$BACKUPDIR"
cp -a "$ACCOUNTSDIR" "$BACKUPDIR"

