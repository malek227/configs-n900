#!/bin/sh

APPS="signond"
PIDS=`pidof $APPS` && kill -1 $PIDS

