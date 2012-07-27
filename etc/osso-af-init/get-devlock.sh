#!/bin/sh
#
# This file is part of osso-af-startup.
#
# Copyright (C) 2004-2007 Nokia Corporation. All rights reserved.
#
# Contact: Gabriel Schulhof <gabriel.schulhof@nokia.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA

dbus-send --system --type=method_call \
 --dest="com.nokia.mce" --print-reply \
 "/com/nokia/mce/request" \
 com.nokia.mce.request.get_devicelock_mode | \
 grep unlocked > /dev/null
if [ $? = 0 ]; then
  echo "unlocked"
else
  echo "locked"
fi
