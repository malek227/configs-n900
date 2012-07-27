#!/bin/sh
FILE="$HOME/.activesync-backup.tar.gz"

if [ ! -f "$FILE" ]
then
#no backup file. Return success
exit 0
fi

if [ ! -s "$FILE" ]
then
#empty backup file. Return success
exit 0
fi

cd $HOME
tar xzvf .activesync-backup.tar.gz
rm -rf .activesync-backup.tar.gz
exit 0
