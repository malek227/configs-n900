#!/bin/sh
SEL_THEME_PATH=/tmp
SEL_THEME_NAME=.theme_selected

if [ ! -d "$SEL_THEME_PATH" ] ; then 
  mkdir -p "$SEL_THEME_PATH"; 
fi

ls -l /etc/hildon/ | grep " theme " | sed 's/.*-> //' > "$SEL_THEME_PATH"/"$SEL_THEME_NAME"
