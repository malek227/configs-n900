#!/bin/sh
# Application Framework environment variable defines for all AF programs,
# programs started by AF startup scripts and the D-BUS session bus.
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

# cancel 'set -e' because grep may return non-zero
set +e

export AF_INIT_DIR=/etc/osso-af-init

source_if_is()
{
  farg=$AF_INIT_DIR/$1 

  shift

  if [ -f $farg ]; then
    source $farg $@
  else
    echo "AF Warning: '$farg' not found"
  fi
}

# user name is appended for multi-user Scratchbox
USER=`whoami`
if [ "x$USER" = "xroot" ]; then
  export SESSION_BUS_ADDRESS_FILE=/tmp/session_bus_address.user
  export SESSION_BUS_PID_FILE=/tmp/dbus_session_bus.pid.user
else
  export SESSION_BUS_ADDRESS_FILE=/tmp/session_bus_address.$USER
  export SESSION_BUS_PID_FILE=/tmp/dbus_session_bus.pid.$USER
fi

# these could have changed since last sourcing
if test -f $AF_INIT_DIR/locale; then
  source $AF_INIT_DIR/locale
else
  unset LC_ALL
  export LC_MESSAGES=en_GB
  export LANG=en_GB
  export LC_TIME=en_GB
fi

if [ -r $SESSION_BUS_ADDRESS_FILE ]; then
  source $SESSION_BUS_ADDRESS_FILE
fi
# Note: TMPDIR uses flash but UI states are saved to RAM
export TMPDIR=/var/tmp ;# needed here because sudo clears this

# the following should not change in run-time
if [ "x$AF_DEFINES_SOURCED" = "x" ]; then
  export AF_PIDDIR=/tmp/af-piddir
  if [ ! -d $AF_PIDDIR ]; then
    # note, no write to flash involved here
    mkdir $AF_PIDDIR
    # I'm not the only one writing here
    chmod 777 $AF_PIDDIR
  fi

  if [ ! -e /targets/links/scratchbox.config ]; then
    if [ "x$DISPLAY" = "x" ]; then
      export DISPLAY=:0.0
    fi
  fi
  export LAUNCHWRAPPER=$AF_INIT_DIR/launch-wrapper.sh

  # check the machine
  echo `uname -m` | grep "^armv" > /dev/null
  if [ $? = 0 -a -x /usr/sbin/dsmetool ]; then
    export LAUNCHWRAPPER_NICE=$AF_INIT_DIR/nice-launch-wrapper.sh
    export LAUNCHWRAPPER_NICE_KILL=$AF_INIT_DIR/nice-kill-launch-wrapper.sh
    export LAUNCHWRAPPER_NICE_TRYRESTART=$AF_INIT_DIR/nice-launch-wrapper-tryrestart.sh
    export LAUNCHWRAPPER_TRYRESTART=$AF_INIT_DIR/launch-wrapper-tryrestart.sh
  else
    export LAUNCHWRAPPER_NICE=$LAUNCHWRAPPER
    export LAUNCHWRAPPER_NICE_KILL=$LAUNCHWRAPPER
    export LAUNCHWRAPPER_NICE_TRYRESTART=$LAUNCHWRAPPER
    export LAUNCHWRAPPER_TRYRESTART=$LAUNCHWRAPPER
  fi

  export STATESAVEDIR=/tmp/osso-appl-states
  if [ ! -d $STATESAVEDIR ]; then
    mkdir $STATESAVEDIR
    chmod 01777 $STATESAVEDIR
  fi

  if [ ! -d /scratchbox ]; then
    if [ ! -e /tmp/.opi.tmp -a -x /usr/bin/osso-product-info ]; then
      if [ "x$USER" = "xroot" ]; then
        _SUDO=''
      else
        _SUDO='sudo'
      fi
      $_SUDO /usr/bin/osso-product-info 1> /tmp/.opi.tmp.tmp 2> /dev/null
      $_SUDO /bin/mv -f /tmp/.opi.tmp.tmp /tmp/.opi.tmp 2> /dev/null
      unset _SUDO
    fi
    if [ -r /tmp/.opi.tmp ]; then
      VNAMES=`awk -F '=' '{print $1}' < /tmp/.opi.tmp`
      source /tmp/.opi.tmp
      export $VNAMES
      unset VNAMES
    fi
  fi

  # Mount point of the MMC
  export MMC_MOUNTPOINT='/media/mmc1' MMC_DEVICE_FILE='/dev/mmcblk0p1'

  # Only the following hardware types have internal MMCs
  if test "x$OSSO_PRODUCT_HARDWARE" = "xRX-34" || \
     test "x$OSSO_PRODUCT_HARDWARE" = "xRX-44" || \
     test "x$OSSO_PRODUCT_HARDWARE" = "xRX-48" || \
     test "x$OSSO_PRODUCT_HARDWARE" = "xRX-51"; then

    export INTERNAL_MMC_MOUNTPOINT='/home/user/MyDocs'
    export INTERNAL_MMC_SWAP_LOCATION=$INTERNAL_MMC_MOUNTPOINT
    export OSSO_SWAP=$INTERNAL_MMC_MOUNTPOINT

    # enable UPnP/AV support
    export UPNP_ROOT='upnpav://'

    # enable multiple BT device support
    export DISABLE_GATEWAY=1
    export HILDON_FM_OBEX_ROOT='obex://'
  else
    export OSSO_SWAP=$MMC_MOUNTPOINT
  fi
  export ILLEGAL_FAT_CHARS=\\\/\:\*\?\<\>\| MAX_FILENAME_LENGTH=255

  # MMC swap file location (directory)
  export MMC_SWAP_LOCATION=$MMC_MOUNTPOINT

  # The MyDocs directory
  if test "x$INTERNAL_MMC_MOUNTPOINT" = "x"; then
    export MYDOCSDIR=$HOME/MyDocs
  else
    export MYDOCSDIR=$INTERNAL_MMC_MOUNTPOINT
  fi

  source_if_is osso-gtk.defs
# There is no matchbox.defs in Fremantle
#  source_if_is matchbox.defs
  source_if_is keyboard.defs
  source_if_is sdl.defs

  # Enabling SAPWOOD_DEBUG when device is in rd-mode and in scratchbox
  if [ -d /scratchbox ]; then
    export SAPWOOD_DEBUG=scaling
  elif [ -f /usr/bin/cal-tool ]; then
    if (/usr/bin/cal-tool --get-rd-mode | grep enabled) > /dev/null; then
      export SAPWOOD_DEBUG=scaling
    fi
  fi

  export AF_DEFINES_SOURCED=1

fi  ;# AF_DEFINES_SOURCED definition check
