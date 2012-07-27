#!/bin/sh

FNAME=/home/user/.clockd.conf

# Set saved TZ
if [ -f $FNAME ]; then 
  SYSTEM_TZ=`/bin/grep system_tz $FNAME | /bin/sed s/system_tz=//g`
  if [ "$SYSTEM_TZ"_ != "_" ]; then
    logger -t clockd restoring timezone $SYSTEM_TZ
    echo "restore_tz=:$SYSTEM_TZ" >> $FNAME
  else
    logger -t clockd did not restore timezone $SYSTEM_TZ
  fi
else
    logger -t clockd restore did not find $FNAME
fi

logger -t clockd "Restarting clock daemon" 
kill `pidof clockd`

exit 0

