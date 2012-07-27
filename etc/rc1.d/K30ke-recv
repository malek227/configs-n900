#!/bin/sh
# 
# ke-recv	HAL-based automatic mounting etc.
#
# Copyright (C) 2004-2009 Nokia Corporation. All rights reserved.
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

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/sbin/ke-recv
NAME=ke-recv
DESC="ke-recv"
USER=root
DTOOL=/usr/sbin/dsmetool
PARAMS=''

test -x $DAEMON || exit 0

# create place for ke-recv's GConf keys to RAM disk and make a symbolic
# link to it for keys that do not need to be permanent
mkdir -p /tmp/gconf-dir/system/osso/af
chmod ugo+rwx -R /tmp/gconf-dir
if [ -d /etc/osso-af-init/gconf-dir/system/osso/af ]; then
  rm -rf /etc/osso-af-init/gconf-dir/system/osso/af
fi
if [ ! -e /etc/osso-af-init/gconf-dir/system/osso/af ]; then
  ln -s /tmp/gconf-dir/system/osso/af \
        /etc/osso-af-init/gconf-dir/system/osso/af
fi

source /etc/osso-af-init/af-defines.sh

# FIXME: these should come from startup scripts
export MMC_MOUNTPOINT='/media/mmc1'
export INTERNAL_MMC_MOUNTPOINT='/home/user/MyDocs'

/sbin/lsmod | grep "\(g_ether\)" > /dev/null
if [ $? = 0 ]; then
  echo "$DESC: USB networking enabled, ignoring USB cable"
  export OSSO_KE_RECV_IGNORE_CABLE=1
fi

case "$1" in
  start)
        modprobe omap_hsmmc
        modprobe sd_mod

	# Start daemons
	echo -n "Starting $DESC: "

        # check if this is the first boot
        if [ -e /home/user/first-boot-flag ]; then
                export FIRST_BOOT=1
        fi

        # check if this is TA image
        if [ -x /usr/bin/sysinfo-tool ]; then
                sysinfo-tool -g /device/sw-release-ver | grep -q _TA_
                if [ $? = 0 ]; then
                        export TA_IMAGE=1
                        # modprobe g_nokia automatically in TA images
                        /usr/sbin/pcsuite-enable.sh
                fi
        fi

        if [ "x$TA_IMAGE" = "x" ]; then
                if [ -e /var/lib/ke-recv/usb_phonet_mode ]; then
                        /sbin/modprobe g_nokia
                        rm -f /var/lib/ke-recv/usb_phonet_mode
                        sync
                else
                        # g_file_storage is loaded as the default
                        /sbin/modprobe g_file_storage stall=0 luns=2 removable
                fi
        fi

	if [ -x $DTOOL ]; then
        	$DTOOL -U $USER -n -1 -t $DAEMON
	else
		start-stop-daemon -b --start --quiet --user $USER \
			--exec $DAEMON -- $PARAMS
	fi
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $DESC: "

	if [ -x $DTOOL ]; then
		$DTOOL -k $DAEMON
	else
		start-stop-daemon --stop --quiet --oknodo --user $USER \
			--exec $DAEMON -- $PARAMS
	fi

	echo "$NAME."
	;;
  reload|restart|force-reload)
	#
	#	If the "reload" option is implemented, move the "force-reload"
	#	option to the "reload" entry above. If not, "force-reload" is
	#	just the same as "restart".
	#
	"$0" stop
	"$0" start
	;;
  *)
	N=/etc/init.d/$NAME
	# echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $N {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0
