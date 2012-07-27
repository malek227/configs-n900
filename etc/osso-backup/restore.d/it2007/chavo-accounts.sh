#!/bin/sh
set -x

OS2006_ACC_PATH="/etc/osso-af-init/gconf-dir/apps/osso/rtcom/accounts"
OS2007_ACC_PATH="/etc/osso-af-init/gconf-dir/apps/telepathy/mc/accounts"
GCONF_PATH="/etc/osso-af-init/gconf-dir"
NEW_DIR="/var/lib/gconf/apps/telepathy/mc"

if [ ! $1 ]
then
    exit 0
fi

resultValue=`cat $1 | grep "^${OS2006_ACC_PATH}/.\+$"`

if [ "${resultValue}" ]
then
    rm -rf $OS2007_ACC_PATH
    mkdir -p $NEW_DIR
    mv -f $OS2006_ACC_PATH $OS2007_ACC_PATH
# Create the %gconf.xml files along the new path, in case they are missing
    DIR="$OS2007_ACC_PATH"
    while [ "$DIR" != "$GCONF_PATH" ];
    do
        GCONF_MARKER="$DIR/%gconf.xml"
        if [ ! -f "$GCONF_MARKER" ]; then
            touch "$GCONF_MARKER"
        fi
        DIR="$(dirname $DIR)"
    done
fi

exit 0
