#!/bin/sh

# First we kill Modest to make sure that, when we remove
# all the data, modest won't write again
PIDS=`pidof modest` && kill -15 $PIDS

# Removing modest user data folder
rm -rf /home/user/.modest

# Restore the security modules settings
if [ -f "/usr/bin/nsscfg" ] ; then
nsscfg -c /home/user/.modest/cache   -m "Maemosec certificates" -l /usr/lib/libmaemosec_certman.so.0
fi



exit 0
