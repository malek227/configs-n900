#!/bin/sh

IF="$1"
IP="$2"
PDNS="$3"
SDNS="$4"

# Create resolv.conf to /var/run

TMP_FILENAME="/var/run/resolv.conf.gprs.tmp"
FILENAME="/var/run/resolv.conf.gprs"

if [ -n "$PDNS" ]; then
    echo "nameserver $PDNS" > $TMP_FILENAME
    if [ -n "$SDNS" ]; then
        echo "nameserver $SDNS" >> $TMP_FILENAME
    fi
fi

# create the file atomically

if [ -e $TMP_FILENAME ]; then
    mv $TMP_FILENAME $FILENAME
    
    # Clear dnsmasq cache after getting new nameservers
    kill -SIGHUP `pidof dnsmasq`
fi

/sbin/ifconfig $IF $IP up

/sbin/route add default dev $IF

