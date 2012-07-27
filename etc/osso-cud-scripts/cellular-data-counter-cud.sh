#!/bin/sh
#
# Cellular data counter CUD script
#
# Copyright (C) 2009 Nokia. All rights reserved.
#
# Author: Aapo Makela <aapo.makela@nokia.com>
#

GCONF_DIRECTORY="/system/osso/connectivity/network_type/GPRS"

# Unset values for this plugin
gconftool-2 --unset $GCONF_DIRECTORY/gprs_home_rx_bytes
gconftool-2 --unset $GCONF_DIRECTORY/gprs_home_tx_bytes
gconftool-2 --unset $GCONF_DIRECTORY/gprs_roaming_rx_bytes
gconftool-2 --unset $GCONF_DIRECTORY/gprs_roaming_tx_bytes
gconftool-2 --unset $GCONF_DIRECTORY/gprs_home_last_notification
gconftool-2 --unset $GCONF_DIRECTORY/gprs_roaming_last_notification
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_roaming_notification_period "10000000"
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_home_notification_period "0"

# Unset values for the UI
gconftool-2 --type bool --set $GCONF_DIRECTORY/gprs_home_notification_enabled false
gconftool-2 --type bool --set $GCONF_DIRECTORY/gprs_roaming_notification_enabled true
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_home_warning_limit "1000"
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_roaming_warning_limit "10"
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_home_reset_time "`date +%s`"
gconftool-2 --type string --set $GCONF_DIRECTORY/gprs_roaming_reset_time "`date +%s`"

