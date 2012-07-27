#!/bin/sh

rm -rf $HOME/.modest-backup.tar.gz

echo "$*" | grep -q "comm_and_cal" || exit 0

cd $HOME/
tar czvf .modest-backup.tar.gz --exclude="*.ev-summary.mmap" --exclude=".modest/images/*" .modest
