#!/bin/sh

logger -p user.debug -t NOKIAMESSAGING -- Executing nokiamessaging-postbackup.sh

rm -f /home/user/.intellisyncd/isync_mailstore.bak.db

echo "$*" | grep -q "comm_and_cal" || exit 0

logger -p user.debug -t NOKIAMESSAGING -- Starting nokiamessaging
/usr/bin/launch-intellisyncd.sh -a &

exit 0
