#!/bin/sh

if [ "$1" != "start" ] && [ "$1" != "stop" ] && [ "$1" != "restart" ]; then
  echo "Usage: $0 {start|stop|restart}"
  exit 1
fi

source $LAUNCHWRAPPER_NICE_TRYRESTART $1 mission-control /usr/bin/mission-control
