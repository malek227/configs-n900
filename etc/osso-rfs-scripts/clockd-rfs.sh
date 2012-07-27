#!/bin/sh


#
# Restore clock daemon factory settings
#

logger -t clockd restoring factory settings

/bin/rm -f /home/user/.clockd.conf
/bin/kill `pidof clockd`

