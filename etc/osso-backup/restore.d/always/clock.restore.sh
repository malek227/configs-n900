#!/bin/sh
FILE="$HOME/.clock/alarm.backup"

if [ ! -f "$FILE" ]
then
#no backup file. Return success
exit 0
fi

if [ ! -s "$FILE" ]
then
#empty backup file. Return success
exit 0
fi

CURRENT_TONE=`cat $FILE | grep "alarm-tone=" | sed s/^[^=]*=//`
CUSTOM_TONE=`cat $FILE | grep "alarm-custom=" | sed s/^[^=]*=//`
TONE1=`cat $FILE | grep "alarm-tone1=" | sed s/^[^=]*=//`
TONE2=`cat $FILE | grep "alarm-tone2=" | sed s/^[^=]*=//`
TONE3=`cat $FILE | grep "alarm-tone3=" | sed s/^[^=]*=//`
TIME=`cat $FILE | grep "alarm-time=" | sed s/^[^=]*=//`

gconftool-2 -s /apps/clock/alarm-tone -t string "$CURRENT_TONE"
gconftool-2 -s /apps/clock/alarm-custom -t string "$CUSTOM_TONE"
gconftool-2 -s /apps/clock/alarm-tone1 -t string "$TONE1"
gconftool-2 -s /apps/clock/alarm-tone2 -t string "$TONE2"
gconftool-2 -s /apps/clock/alarm-tone3 -t string "$TONE3"
gconftool-2 -s /apps/clock/alarm-time -t int -- $TIME

rm $FILE

exit 0
