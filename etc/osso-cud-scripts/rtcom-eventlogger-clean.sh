#!/bin/sh

APPS="rtcom-call-ui rtcom-messaging-ui osso-addressbook"

# Apps will be respawned, so we remove the
# file before killing them
rm -rf $HOME/.rtcom-eventlogger
PIDS=`pidof $APPS` && kill -15 $PIDS

