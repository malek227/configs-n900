#!/bin/sh

logger -p user.debug -t NOKIAMESSAGING -- Executing nokiamessaging-restore.sh

pid=`pidof intellisyncd`
if [ ${#pid} -gt 0 ]
then
	# First we kill intellisyncd to make sure that, when we remove
	# all the data, intellisyncd won't write again
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

# Moving intellisyncd user data backup out of delete path
mv -f /home/user/.intellisyncd/isync_mailstore.bak.db /home/user/isync_mailstore.bak.db

# Removing intellisyncd user data folder
logger -p user.debug -t NOKIAMESSAGING -- Removing Intellisync data folder
rm -rf /home/user/.intellisyncd

# Restoring intellisyncd user data backup
logger -p user.debug -t NOKIAMESSAGING -- Restoring Intellisync data backup
mkdir /home/user/.intellisyncd
mkdir /home/user/.intellisyncd/attachments
mkdir /home/user/.intellisyncd/body
mkdir /home/user/.intellisyncd/log
mv -f /home/user/isync_mailstore.bak.db /home/user/.intellisyncd/isync_mailstore.db
chmod -R 755 /home/user/.intellisyncd
chmod 644 /home/user/.intellisyncd/isync_mailstore.db
touch /home/user/.intellisyncd/needs_sync

# Start nokiamessaging 
logger -p user.debug -t NOKIAMESSAGING -- Starting nokiamessaging
/usr/bin/launch-intellisyncd.sh -a &

exit 0
