#!/bin/sh
# OSSO Connectivity UI dialogs startup/shutdown script

if [ "x$AF_PIDDIR" = "x" ]; then
  echo "$0: Error, AF_PIDDIR is not defined"
  return 2
fi
if [ ! -w $AF_PIDDIR ]; then
  echo "$0: Error, directory $AF_PIDDIR is not writable"
  return 2
fi

prefix=/usr
exec_prefix=${prefix}
PROG=${exec_prefix}/bin/osso-connectivity-ui-conndlgs
SVC="Connectivity UI"

case "$1" in
start)  START=TRUE
        ;;
stop)   START=FALSE
        ;;
restart)
        $0 stop
        sleep 1
        $0 start
	return 0
	;;
*)      echo "Usage: $0 {start|stop|restart}"
        return 1
        ;;
esac

if [ $START = TRUE ]; then
  # check that required environment is defined
  if [ "x$DISPLAY" = "x" ]; then
    echo "$0: Error, DISPLAY is not defined"
    return 2
  fi

  $LAUNCHWRAPPER_NICE_TRYRESTART start "$SVC" $PROG
else
  $LAUNCHWRAPPER_NICE_TRYRESTART stop "$SVC" $PROG
fi
