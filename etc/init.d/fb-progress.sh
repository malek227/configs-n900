#!/bin/sh
#
# Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA

PIDFILE=/tmp/fb-progress.pid
BAR_IMGDIR=/usr/share/icons/hicolor/scalable/hildon
BAR=indicator_update

SECS=9

case "$1" in
start)	
        # wait until we have /proc and /dev
        while [ ! -f /proc/bootreason -o ! -e /dev/tty0  ]; do
            sleep 1;
        done
	# don't show progress bar if device started to ACTDEAD first
        BOOTSTATE=`getbootstate 2>/dev/null`
        if [ "$BOOTSTATE" != "ACT_DEAD" \
	     -a ! -f /tmp/skip-fb-progress.tmp ]; then
                AF_PIDDIR=/tmp/af-piddir
                if [ ! -d $AF_PIDDIR ]; then
                    # note, no write to flash involved here
                    mkdir $AF_PIDDIR
                    # I'm not the only one writing here
                    chmod 777 $AF_PIDDIR
                fi
        	echo "Starting: fb-progress"
        	fb-progress -c -g $BAR_IMGDIR/$BAR $SECS > /dev/null 2>&1 &
        	echo "$!" > $PIDFILE
        	chmod 666 $PIDFILE
	fi
        rm -f /tmp/skip-fb-progress.tmp
	;;
stop)	if [ -f $PIDFILE ]; then
		PID=$(cat $PIDFILE)
		if [ -d /proc/$PID ]; then
			kill -TERM $PID
		fi
		rm $PIDFILE
	fi
        # this is for the case of USER -> ACTDEAD -> USER
        touch /tmp/skip-fb-progress.tmp
	;;
restart)
	echo "$0: not implemented"
	exit 1
	;;
force-reload)
	echo "$0: not implemented"
	exit 1
	;;
*)	echo "Usage: $0 {start|stop}"
	exit 1
	;;
esac
