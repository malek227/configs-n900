#!/bin/sh

IF=$1

FILENAME="/var/run/resolv.conf.gprs"

if [ -e $FILENAME ]; then
    rm $FILENAME
fi

/sbin/route del default dev $IF

