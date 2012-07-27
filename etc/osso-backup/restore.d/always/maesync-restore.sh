#!/bin/sh
#
# @file maesync-restore.sh
# This file is part of MaeSync.
# Script to be run after restoring backup data
#
# Copyright (C) 2008 Nokia Corporation. All rights reserved.
# 
# Contact: Biris Ilias <ilias.biris@nokia.com>
#
# This software, including documentation, is protected by copyright
# controlled by Nokia Corporation. All rights are reserved. Copying,
# including reproducing, storing, adapting or translating, any or all
# of this material requires the prior written consent of Nokia Corporation.
# This material also contains confidential information which may not be
# disclosed to others without the prior written consent of Nokia.
#



MAESYNCDIR="/home/user/.maesync"
BACKUPDIR="/tmp/.maesync"

if [ -d $BACKUPDIR ]; then
	/usr/sbin/dsmetool -S 9 -k "/usr/bin/syncd"
	rm -rf $MAESYNCDIR
	mv $BACKUPDIR $MAESYNCDIR
fi	
