#!/bin/sh

#   This file is part of as-daemon
#
#   Copyright © 2009 Nokia Corporation and/or its subsidiary(-ies).
#   All rights reserved.
#
#   Contact: Moises Martinez Garcia <moises.martinez@nokia.com>
#
#   This software, including documentation, is protected by copyright
#   controlled by Nokia Corporation. All rights are reserved.
#
#   Copying, including reproducing, storing, adapting or translating,
#   any or all of this material requires the prior written consent of
#   Nokia Corporation. This material also contains confidential
#   information which may not be disclosed to others without the prior
#   written consent of Nokia.

# Script for resetting factory settings (RFS) for 'Mail for Exchange'

# 0 - no debus output
# 1 - show critical warnings only
# 2 - show informaiton messages also
# 3 - show debug messages also
debug=0

# Function to check if the main MfE account exists
as_account_exists() {
    test $debug -gt 1 && echo "Checking if MfE acocunt exists..."

    # check if MfE setup is in progress
    setup_type=`gconftool-2 --get-type /apps/activesync/setup`
    if [ $setup_type != "bool" ]; then
        test $debug -gt 1 && echo "Incorrect type of the 'setup' flag!"
        return 1
    fi
    setup_value=`gconftool-2 --get /apps/activesync/setup`
    if [ $setup_value != "false" ]; then
        test $debug -gt 1 && echo "Cannot restore default settings during account setup"
        return 1
    fi

    # check the main account directory
    if gconftool-2 --dir-exists /apps/activesync/ActiveSyncAccount1 ; then
        test $debug -gt 2 && echo "The main MfE account dir exists in gconf"
    else
        test $debug -gt 1 && echo "The main MfE account dir does not exist in gconf"
        return 1
    fi

    # check exchange server address for the main MfE account
    if gconftool-2 --dir-exists /apps/activesync/ActiveSyncAccount1/connection ; then
        test $debug -gt 2 && echo "The main MfE account connection dir exists in gconf"
    else
        test $debug -gt 1 && echo "The main MfE account connection  dir does not exist in gconf"
        return 1
    fi
    addr_type=`gconftool-2 --get-type /apps/activesync/ActiveSyncAccount1/connection/exchange_server`
    if [ $addr_type = "string" ]; then
        test $debug -gt 2 && echo "The MfE server name key type matches: [$addr_type]"
    else
        test $debug -gt 1 && echo "The MfE server name key type does not match: [$addr_type]"
        return 1
    fi
    addr_value=`gconftool-2 --get /apps/activesync/ActiveSyncAccount1/connection/exchange_server`
    if [ -z "$addr_value" ]; then
        test $debug -gt 1 && echo "The server name does not exist for the main account"
        return 1
    else
        test $debug -gt 2 && echo "The server name exists for the main account: [$addr_value]"
    fi
    modest_key_type=`gconftool-2 --get-type /apps/activesync/ActiveSyncAccount1/modest_account_key`
    if [ $modest_key_type = "string" ]; then
        test $debug -gt 2 && echo "The modest account key type matches: [$modest_key_type]"
    else
        test $debug -gt 1 && echo "The modest account key type does not match: [$modest_key_type]"
        return 1
    fi
    modest_key_value=`gconftool-2 --get /apps/activesync/ActiveSyncAccount1/modest_account_key`
    if [ -z "$modest_key_value" ]; then
        test $debug -gt 1 && echo "The modest key does not exist for the main account"
        return 1
    else
        test $debug -gt 2 && echo "The modest key exists for the main account: [$modest_key_value]"
    fi
    modest_disp_name=$modest_key_value"/display_name"
    test $debug -gt 2 && echo "The modest display name key: [$modest_disp_name]"
    modest_name_type=`gconftool-2 --get-type $modest_disp_name`
    if [ $modest_name_type = "string" ]; then
        test $debug -gt 2 && echo "The modest name key type matches"
    else
        test $debug -gt 1 && echo "The modest name key type does not match: [$modest_name_type]"
        return 1
    fi
    modest_name_value=`gconftool-2 --get ${modest_disp_name}`
    if [ -z "$modest_name_value" ]; then
        test $debug -gt 1 && echo "The modest name does not exist"
        return 1
    else
        test $debug -gt 2 && echo "The modest name exists: [$modest_name_value]"
    fi

    test $debug -gt 1 && echo "Checking if MfE acocunt exists done"
    return 0
}

# Get the localized string
# @param[in] String to be translated
# @param[in] Text domain, "as-config-applet" if not passed
as_get_string() {
    if [ $# -eq 0 ]; then
        test $debug -gt 0 && echo "You need to pass at least the string to be translated"
        return 1;
    fi
    local domain="as-config-applet"
    if [ $# -eq 2 ]; then
        $domain=$2
        test $debug -gt 2 && echo "Text domain: $domain"
    fi

    perl -e "use Locale::gettext; use POSIX; setlocale(LC_MESSAGES, \"en_US\"); \
        textdomain(\"$domain\"); print gettext(\"$1\");"
    return 0
}

# Function to restore the default settings
# Returns:
# 0 - Success
# 1 - Warning: Not all the parameters were reset
# 2 - Fatal error
as_restore_defaults() {
    test $debug -gt 1 && echo "Restoring default settings..."

    # result of the reset operation
    local result=0

    # restore the "Peak start time" setting
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/schedule/peak_start_tm 480
    then
        test $debug -gt 1 && echo "Could not reset peak start time"
        $result=1
    fi

    # restore the "Peak end time" setting
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/schedule/peak_end_tm 960
    then
        test $debug -gt 1 && echo "Could not reset peak end time"
        $result=1
    fi

    # restore the "Peak days" setting
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/schedule/peak_days 31
    then
        test $debug -gt 1 && echo "Could not reset peak days"
        $result=1
    fi

    # restore the "Peak schedule" setting
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/schedule/peak_schedule 30
    then
        test $debug -gt 1 && echo "Could not reset peak schedule"
        $result=1
    fi

    # restore the "Off-peak schedule" setting
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/schedule/off_peak_schedule -- -1
    then
        test $debug -gt 1 && echo "Could not reset off-peak schedule"
        $result=1
    fi

    # restore the "Connection"->"Conflict resolution" -> 'Server takes priority'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/sync/conflict_policy 1
    then
        test $debug -gt 1 && echo "Could not reset sync conflict policy"
        $result=1
    fi

    # restore the "E-mail"->"Account title" -> 'Mail for Exchange'
    account_title=`as_get_string activesync_va_service_provider`
    test $debug -gt 2 && echo "MfE account title: [$account_title]"
    if ! gconftool-2 -st string /apps/activesync/ActiveSyncAccount1/account_name "$account_title"
    then
        test $debug -gt 1 && echo "Could not reset the account name in MfE settings"
        $result=1
    fi
    if ! gconftool-2 -st string \
        `gconftool-2 -g /apps/activesync/ActiveSyncAccount1/modest_account_key`"/display_name" \
        "$account_title"
    then
        test $debug -gt 1 && echo "Could not reset the account name in Modest settings"
        $result=1
    fi

    # restore the "E-mail"->"Signature" -> 'Sent from my Nokia N900'
    default_signature="mcen_va_default_signature_tablet"
    test $debug -gt 2 && echo "MfE default signature: `as_get_string $default_signature`"
    if ! gconftool-2 -st string /apps/activesync/ActiveSyncAccount1/email/sig "$default_signature"
    then
        test $debug -gt 1 && echo "Could not reset the account name in Modest settings"
        $result=1
    fi

    # restore the "E-mail"->"Use signature" -> 'FALSE'
    if ! gconftool-2 -st bool /apps/activesync/ActiveSyncAccount1/email/use_sig false
    then
        test $debug -gt 1 && echo "Could not reset use-signature setting"
        $result=1
    fi
    #

    # restore the "E-mail"->"Syncronize messages back" -> '3 days'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/email/past_time 2
    then
        test $debug -gt 1 && echo "Could not reset sync messages back setting"
        $result=1
    fi

    # restore the "E-mail"->"When sending e-mail" -> 'Send immediately'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/email/send_policy 0
    then
        test $debug -gt 1 && echo "Could not reset sync messages send policy"
        $result=1
    fi

    # restore the "Calendar and tasks"->"Calendar name" -> 'N900'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/calendar/id 1
    then
        test $debug -gt 1 && echo "Could not reset calendar ID"
        $result=1
    fi

    # restore the "Calendar and tasks"->"Synchronize calendar back" -> '2 weeks'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/calendar/past_time 4
    then
        test $debug -gt 1 && echo "Could not reset calendar past time setting"
        $result=1
    fi

    # restore the "Calendar and tasks"->"Synchronize completed tasks" -> 'FALSE'
    if ! gconftool-2 -st bool /apps/activesync/ActiveSyncAccount1/tasks/sync_completed false
    then
        test $debug -gt 1 && echo "Could not reset sync completed tasks setting"
        $result=1
    fi

    # restore the "Contacts"->"First synchronization" -> 'Keep items on device'
    if ! gconftool-2 -st int /apps/activesync/ActiveSyncAccount1/contacts/first_sync 0
    then
        test $debug -gt 1 && echo "Could not reset contacts first sync policy"
        $result=1
    fi

    test $debug -gt 1 && echo "Restoring default settings done"
    return $result
}

# check if the MfE account exists
if as_account_exists ; then
    test $debug -gt 1 && echo "MfE Account exists! Restoring default settings..."
else
    test $debug -gt 1 && echo "MfE account does not exist. Cannot restore default settings"
    exit 0
fi

# restore the default settings if it does
if as_restore_defaults; then
    test $debug -gt 1 && echo "Successfully restored default settings"
else
    test $debug -gt 1 && echo "Restore default settings operation failed"
fi

exit 0
