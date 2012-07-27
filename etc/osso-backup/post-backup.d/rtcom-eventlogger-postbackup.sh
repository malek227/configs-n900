#!/bin/sh

# Remove backup files, otherwise they will be restored on next restore even if
# the user does not select "Communication and Calendar" because the restore
# script does not know the selected items.
# See also https://projects.maemo.org/bugzilla/show_bug.cgi?id=158351

cd $HOME/.rtcom-eventlogger/
rm backup.tgz backup.db

