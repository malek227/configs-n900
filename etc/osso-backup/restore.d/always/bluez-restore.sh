#!/bin/sh

if [ -z "$SUDO_COMMAND" ]; then
	sudo /etc/osso-backup/restore.d/always/bluez-restore.sh $@
	exit 0
fi

PATH="/sbin:/usr/sbin:/bin:/usr/bin"

if [ "$1" ]; then
	if [ -z "`grep /var/lib/bluetooth $1`" ] && [ -z "`grep /etc/bluetooth/name $1`" ]; then
		exit 0;
	fi
fi

MY_BDA=`cat /sys/class/bluetooth/hci0/address`

[ -z "$MY_BDA" ] && exit 1

if [ -f "/var/lib/bluetooth/bdaddr.hci0" ] ; then
        echo $MY_BDA > /var/lib/bluetooth/bdaddr.hci0
fi

CORRECT_DIR="/var/lib/bluetooth/$MY_BDA"

OLD_DIR=`find /var/lib/bluetooth -maxdepth 1 -type d \! -name "$MY_BDA" \! -name bluetooth|head -n 1`

if [ "$OLD_DIR" ]; then
	rm -rf $CORRECT_DIR
	mv $OLD_DIR $CORRECT_DIR
fi

BK_MODE=`egrep ^mode $CORRECT_DIR/config|awk '{ print $2 }'`

if [ -z "$BK_MODE" ]; then
	BK_MODE="off"
fi

NAME=""

if [ "$1" ] && [ "`grep /etc/bluetooth/name $1`" ] && [ ! -f "$CORRECT_DIR/config" ]; then
	NAME=`cat /etc/bluetooth/name`
fi

if [ -z "$NAME" ] && [ -f "$CORRECT_DIR/config" ]; then
	NAME=`egrep ^name $CORRECT_DIR/config|sed 's/^name //'`
fi

/usr/bin/maemo-bluez-restore "$NAME" "$BK_MODE"
