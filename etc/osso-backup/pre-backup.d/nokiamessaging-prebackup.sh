#!/bin/sh

logger -p user.debug -t NOKIAMESSAGING -- Executing nokiamessaging-prebackup.sh

echo "$*" | grep -q "comm_and_cal" || exit 0

logger -p user.debug -t NOKIAMESSAGING -- Stopping nokiamessaging
pid=`pidof intellisyncd`
if [ ${#pid} -gt 0 ]
then
	# First we kill intellisyncd to make sure that intellisyncd won't write again
	logger -p user.debug -t NOKIAMESSAGING -- Stopping nokiamessaging

	# We need to create this file so that intellisyncd will return proper exit
	# code to prevent upstart from respawning intellisyncd 
	touch /home/user/.intellisyncd/disabled
	dbus-send --system --dest='com.nokia.email.IS' --type='method_call' /com/nokia/email/IS com.nokia.email.IS.Stop
	
	logger -p user.debug -t NOKIAMESSAGING -- Waiting for intellisyncd to die
	len=1
	while [ $len -gt 0 ]
	do
		sleep 1
		pid=`pidof intellisyncd`
        len=${#pid}
	done
	logger -p user.debug -t NOKIAMESSAGING -- Intellisyncd died
else
	logger -p user.debug -t NOKIAMESSAGING -- No need to Stop nokiamessaging
fi

# Clear SQL records:
if [ -e /usr/share/intellisync/nokiamessaging-backup.sql ]
then
	logger -p user.debug -t NOKIAMESSAGING -- Trimming backup data
	cp /home/user/.intellisyncd/isync_mailstore.db /home/user/.intellisyncd/isync_mailstore.bak.db
	sqlite3 -echo /home/user/.intellisyncd/isync_mailstore.bak.db < /usr/share/intellisync/nokiamessaging-backup.sql 
else
	logger -p user.error -t NOKIAMESSAGING -- Cannot find nokiamessaging-backup script!
fi

exit 0
