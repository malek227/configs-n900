#!/bin/sh

# Clean up known temporary backup locations.

# mission-control
rm /tmp/.rtcom-accounts/accounts.cfg

# clock
rm $HOME/.clock/alarm.backup

# eventlogger
rm $HOME/.rtcom-eventlogger/backup.db

# calendar
rm $HOME/.calendar/calendardb.backup

# volume
rm $HOME/MyDocs/.volbak

# addressbook
rm $HOME/.osso-abook/db/backup.vcf

# maesync
rm -rf /tmp/.maesync

# mafw
rm $HOME/.mafw.db.backup
rm $HOME/.mafw-playlists.backup

# modest
rm $HOME/.modest-backup.tar.gz

