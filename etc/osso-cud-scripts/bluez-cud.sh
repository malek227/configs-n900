#!/bin/sh

AF_DEFINES="/etc/osso-af-init/af-defines.sh"
PRODUCT_NAME="Nokia NXX"

if [ "$OSSO_PRODUCT_NAME" ]; then
	PRODUCT_NAME="Nokia $OSSO_PRODUCT_NAME"
elif [ -f $AF_DEFINES ]; then
	. $AF_DEFINES
	if [ "$OSSO_PRODUCT_NAME" ]; then
		PRODUCT_NAME="Nokia $OSSO_PRODUCT_NAME"
	fi
fi

/usr/bin/maemo-bluez-cud "$PRODUCT_NAME"
