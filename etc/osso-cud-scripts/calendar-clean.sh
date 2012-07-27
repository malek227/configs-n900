#! /bin/sh

# clean up all calendars in calendar db except sychronized and private calendars
chmod 777 $HOME/.calendar/calendardb
rm -rf $HOME/.calendar/calendardb
run-standalone.sh /usr/bin/add_default_cal
