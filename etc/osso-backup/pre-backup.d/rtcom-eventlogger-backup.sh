#!/bin/sh

# Copy to a temporary location so that restore script can
# manually move them to the original one and restart
# the applications using it.

cd $HOME/.rtcom-eventlogger/
tar czf backup.tgz el-v1.db plugins attachments

