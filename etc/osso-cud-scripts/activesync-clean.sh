#!/bin/sh

# First we kill as-daemon and modest to make sure that, when we remove
# all the data, as-daemon and modest won't write again
PIDS=`pidof modest` && kill -15 $PIDS

/etc/init.d/as-daemon-0 stop

# Removing modest user data folder
rm -rf /home/user/.qmf

/etc/init.d/as-daemon-0 start

exit 0
