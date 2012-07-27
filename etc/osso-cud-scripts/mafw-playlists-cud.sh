#!/bin/sh

# stop the playlist daemon
/usr/sbin/dsmetool -U user -k /usr/bin/mafw-playlist-daemon

rm -r /home/user/.mafw-playlists
