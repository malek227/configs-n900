#!/bin/sh

SEL_THEME_PATH=/tmp/.theme_selected

if [ "$1" ]; then
	if [ -z "`grep "$SEL_THEME_PATH" "$1"`" ]; then
		exit 0;
	fi
	
	# backup file contains selected theme path	
	THEME="`cat $SEL_THEME_PATH`"

	# basic check if the theme exists
	if [ -f ""$THEME"/index.theme" ] ; then
		sudo /usr/bin/personalisation "$THEME"
	fi	
fi
