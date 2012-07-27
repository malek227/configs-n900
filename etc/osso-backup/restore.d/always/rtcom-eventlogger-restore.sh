#!/bin/sh

APPS="rtcom-call-ui rtcom-messaging-ui osso-addressbook hildon-status-menu"
FILELIST="$1"

DIR="$HOME/.rtcom-eventlogger"
cd $DIR

# If there is no backup to restore, we exit before moving files
grep -qE "$DIR/backup.tgz|$DIR/backup.db" $FILELIST || exit 0

# If there's a new version we'll rename it so that if old-format backup
# is restored, it will be converted to a new format (and new filename).
if [ -f el-v1.db ]; then
    mv el-v1.db el-v1-before-restore.db
fi

# Handle both old (only db) and new (db and attachments) backup formats
if grep -qE "$DIR/backup.tgz" $FILELIST && [ -f backup.tgz ]; then
    tar xzf backup.tgz
    rm backup.tgz
elif grep -qE "$DIR/backup.db" $FILELIST && [ -f backup.db ]; then
    mv backup.db el.db
else
    # We don't know what to do, so we fail
    exit 1
fi

