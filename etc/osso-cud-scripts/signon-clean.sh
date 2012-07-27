#!/bin/sh

APPS="signond"

rm -f /home/user/.signon/user_db.xml
PIDS=`pidof $APPS` && kill -1 $PIDS
