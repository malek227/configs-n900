#!/bin/sh

PATH="/sbin:/usr/sbin:/bin:/usr/bin"

# Stop pulseaudio.
stop pulseaudio
sleep 2
killall -9 pulseaudio

# Clean up saved pulseaudio state.
rm -fr /var/lib/pulse
mkdir /var/lib/pulse
chown pulse:pulse /var/lib/pulse
chmod 700 /var/lib/pulse

