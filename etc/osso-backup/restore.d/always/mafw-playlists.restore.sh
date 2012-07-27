#!/bin/sh

if [ -e /home/user/.mafw-playlists.backup ] ; then
	/usr/sbin/dsmetool -U user -k /usr/bin/mafw-playlist-daemon
	rm -r /home/user/.mafw-playlists
	mv /home/user/.mafw-playlists.backup /home/user/.mafw-playlists
fi
