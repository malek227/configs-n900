#!/bin/sh

# Author: David Kedves <dkedves@blumsoft.eu>
# Contact: Karoliina T. Salminen <karoliina.t.salminen@nokia.com>
#
# Copyright (C) 2009 Nokia Corporation.
#

FACTORY_SETTINGS="/usr/share/osso-startup-wizard/startup-ui-settings.config"
VARIANT_SETTINGS="/usr/share/osso-af-init/startup-ui-settings.config"

if [ -f ${VARIANT_SETTINGS} ]; then
DEFAULT_LANGUAGE=\
`awk -F '=' '/^default-language/ { print $2; exit; }' < ${VARIANT_SETTINGS}`
DEFAULT_REGION=\
`awk -F '=' '/^default-region/ { print $2; exit; }' < ${VARIANT_SETTINGS}`
fi

if [ -f ${FACTORY_SETTINGS} ]; then
[ -z "${DEFAULT_LANGUAGE}" ] && DEFAULT_LANGUAGE=\
`awk -F '=' '/^default-language/ { print $2; exit; }' < ${FACTORY_SETTINGS}`
[ -z "${DEFAULT_REGION}" ] && DEFAULT_REGION=\
`awk -F '=' '/^default-region/ { print $2; exit; }' < ${FACTORY_SETTINGS}`
fi

[ -z "${DEFAULT_LANGUAGE}" ] && DEFAULT_LANGUAGE=en_GB
[ -z "${DEFAULT_REGION}" ] && DEFAULT_REGION=en_GB

echo "Setting locale (lang=$DEFAULT_LANGUAGE, region=$DEFAULT_REGION)..."

/usr/bin/setlocale $DEFAULT_REGION $DEFAULT_LANGUAGE

exit 0
