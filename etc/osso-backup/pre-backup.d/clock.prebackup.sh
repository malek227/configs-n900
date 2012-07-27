#!/bin/sh

rm -rf $HOME/.clock/alarm.backup

echo "$*" | grep -q "comm_and_cal" || exit 0

mkdir -p $HOME/.clock

CURRENT_TONE=`gconftool-2 -g /apps/clock/alarm-tone`
TONE1=`gconftool-2 -g /apps/clock/alarm-tone1`
TONE2=`gconftool-2 -g /apps/clock/alarm-tone2`
TONE3=`gconftool-2 -g /apps/clock/alarm-tone3`
CUSTOM_TONE=`gconftool-2 -g /apps/clock/alarm-custom`
TIME=`gconftool-2 -g /apps/clock/alarm-time`

echo "alarm-tone=$CURRENT_TONE" > $HOME/.clock/alarm.backup
echo "alarm-custom=$CUSTOM_TONE" >> $HOME/.clock/alarm.backup
echo "alarm-time=$TIME" >> $HOME/.clock/alarm.backup
echo "alarm-tone1=$TONE1" >> $HOME/.clock/alarm.backup
echo "alarm-tone2=$TONE2" >> $HOME/.clock/alarm.backup
echo "alarm-tone3=$TONE3" >> $HOME/.clock/alarm.backup
