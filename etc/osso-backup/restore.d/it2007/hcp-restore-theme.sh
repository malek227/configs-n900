#!/bin/sh

OSSO_CONF_DIR="${HOME}/.osso"
GTKRC="${OSSO_CONF_DIR}/current-gtk-theme"
MAD_GTKRC="${OSSO_CONF_DIR}/current-gtk-theme.maemo_af_desktop"
MB_THEME="${OSSO_CONF_DIR}/mbtheme"

rm -f $GTKRC
rm -f $MAD_GTKRC
rm -f $MB_THEME

gconftool-2 -u /apps/osso/browser/skin_file
