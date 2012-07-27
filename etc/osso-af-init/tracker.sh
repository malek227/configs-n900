#!/bin/sh
#
# Init script for Tracker
#

DAEMON=/usr/lib/tracker/trackerd
NAME=trackerd
DESC=Tracker
OPTIONS=""

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

case "$1" in
  start)
        log_begin_msg "Starting $DESC..."
	$DAEMON $OPTIONS
        log_end_msg $?
        ;;

  stop)
        log_begin_msg "Stopping $DESC..."
	killall -9 hildon-thumbnailerd
	killall -9 tracker-indexer
	killall -9 tracker-extract
	killall -9 trackerd
        log_end_msg $?
        ;;
  restart|force-reload)
        $0 stop
        sleep 1
        $0 start
        ;;
  *)
        N=/etc/osso-af-init/$NAME
        log_success_msg "Usage: $N {start|stop|restart|force-reload}" >&2
        exit 1
        ;;
esac

#exit 0  
