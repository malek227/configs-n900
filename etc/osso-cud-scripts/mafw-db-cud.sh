#!/bin/sh

# the plugins has to be stopped, otherwise the current DB will be restored automatically
for plugin in /usr/lib/mafw-plugin/*.so; do
	plugin="${plugin##*/}";
	plugin="${plugin%.so}";
	/usr/bin/mafw.sh stop "$plugin" &
done
rm /home/user/.mafw.db
