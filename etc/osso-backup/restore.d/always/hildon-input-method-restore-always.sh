#!/bin/sh

if grep /apps/osso/inputmethod $1 >/dev/null;then
  hildon-im-convert-restored-gconf "$@"
fi
