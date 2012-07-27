#!/bin/sh

echo "$*" | grep -q "comm_and_cal" || exit 0

/usr/bin/activesync-backup-app
