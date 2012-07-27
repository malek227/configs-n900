#!/bin/sh
#
# @file maesync-prebackup.sh
# This file is part of MaeSync.
# if settings category is chosen for backup
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

echo "$*" | grep -q "settings" || exit 0

# Copy to a temporary location so that restore script can
# manually move them to the original one and restart
# the applications using it.

MAESYNCDIR="/home/user/.maesync"
BACKUPDIR="/tmp/.maesync"

rm -rf $BACKUPDIR
cp -a $MAESYNCDIR $BACKUPDIR
