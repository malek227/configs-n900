#!/bin/sh

# clean user cities
rm -rf $HOME/.clock

# clean also everything in gconf
gconftool-2 --recursive-unset /apps/clock