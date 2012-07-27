#!/bin/sh

APPS="Calendar"

# Apps will be respawned, so we copy the
# file before killing them
cp $HOME/.calendar/calendardb.backup $HOME/.calendar/calendardb
PIDS=`pidof $APPS` && kill -15 $PIDS
