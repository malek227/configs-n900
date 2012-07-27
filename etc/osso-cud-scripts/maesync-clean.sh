#! /bin/sh
#
# @file maesync-clean.sh
# clean up maesync user data 
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


PIDS=`pidof syncd` && kill -15 $PIDS
rm -rf $HOME/.maesync
