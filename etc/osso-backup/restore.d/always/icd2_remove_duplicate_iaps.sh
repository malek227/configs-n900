#!/bin/sh

# Copyright (C) 2009 Nokia Corporation. All rights reserved.
# Author: jukka.rissanen@nokia.com

# This script will remove duplicate IAPs from gconf

TAG=`basename $0`
icd_entry=system/osso/connectivity/IAP

# Run gconftool via server or directly if D-Bus is not running
gconftool_run () {
    if gconftool-2 -p &>/dev/null
    then
        gconftool-2 $* 2>/dev/null
    else
        gconftool-2 --direct \
            --config-source xml::/etc/gconf/gconf.xml.defaults \
            $* | sed '1 d' 2>/dev/null
    fi
}

# Get the list of IAPs and then check if there are any duplicates found
# (having a same name or sim_imsi is considered a duplicate)

COUNT=0
TMP_NAME=/tmp/.${TAG}_name.tmp
TMP_IMSI=/tmp/.${TAG}_imsi.tmp
rm -f $TMP_NAME
rm -f $TMP_IMSI

for IAP in `gconftool_run -R /$icd_entry | grep /system | sed 's/:$//'`
do
    NAME=`gconftool_run --get "$IAP/name"`
    # If NAME is set, check for duplicate IAPs.
    if [ ! -z "$NAME" ]; then
        grep -- "^${NAME}$" $TMP_NAME > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            # We found a duplicate
            gconftool_run --recursive-unset "$IAP"
            COUNT=`expr $COUNT + 1`
            logger -t "$TAG" "Removed $IAP by name ($NAME)"
        else
            echo "$NAME" >> $TMP_NAME
        fi
    fi
    # Check for duplicate packet data IAPs by SIM IMSI (ignore user added IAPs)
    SIM_IMSI=`gconftool_run --get "$IAP/sim_imsi"`
    USER_ADDED=`gconftool_run --get "$IAP/user_added"`
    if [ ! -z "$SIM_IMSI" ] && [ "$USER_ADDED" -le "0" ]; then
        grep -- "^${SIM_IMSI}$" $TMP_IMSI > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            # We found a duplicate
            gconftool_run --recursive-unset "$IAP"
            COUNT=`expr $COUNT + 1`
            logger -t "$TAG" "Removed $IAP by SIM IMSI ($SIM_IMSI)"
        else
            echo "$SIM_IMSI" >> $TMP_IMSI
        fi
    fi
done

if [ "$COUNT" -gt 0 ]; then
    logger -t "$TAG" "Restore removed $COUNT duplicate IAP"
fi

rm -f $TMP_NAME
rm -f $TMP_IMSI

exit 0
