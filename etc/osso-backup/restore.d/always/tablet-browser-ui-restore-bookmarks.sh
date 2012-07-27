#!/bin/sh

# Check if bookmarks XML file was restored
# If so, kill browser process to force
# reloading of bookmark data to memory
if grep MyBookmarks.xml $1 >/dev/null;then
  kill `pidof browser`
fi

