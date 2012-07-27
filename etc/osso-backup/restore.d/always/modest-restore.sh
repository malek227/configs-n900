#!/bin/sh
FILE="$HOME/.modest-backup.tar.gz"

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
tar xzvf .modest-backup.tar.gz
rm -rf .modest-backup.tar.gz
exit 0
