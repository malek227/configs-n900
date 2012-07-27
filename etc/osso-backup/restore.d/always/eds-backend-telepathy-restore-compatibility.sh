#!/bin/sh

# This script is kept only for compatibility with backups made with a
# pre-release version of the address book and does nothing with newer
# backups.

DB_DIR=$HOME/.osso-abook/db
TPDB_DIR=$DB_DIR/tp-cache
TPDB_BAK_DIR=$DB_DIR/tp-cache-bak

RESTORE_LIST=$1
if ! [ -e $RESTORE_LIST ]; then
  echo "no restore file found"
  exit 1
fi

if ! grep -q $TPDB_BAK_DIR $RESTORE_LIST; then
  # We are not restoring the contacts    
  exit 0
fi

mkdir -p $TPDB_DIR

for bak_file in $TPDB_BAK_DIR/*
do
  # We don't write to the actual DB file, the tp backend will do that
  # by itself after a reboot
  restore_file=`basename $bak_file`.restore
  cp -f $bak_file $TPDB_DIR/$restore_file
done

rm -rf $TPDB_BAK_DIR

# Make really sure that the EDS factory is really not running so we don't
# have to wait for a reboot to get the restored contacts
/etc/osso/osso-addressbook-stop.sh

exit 0
