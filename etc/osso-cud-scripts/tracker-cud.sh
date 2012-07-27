#!/bin/sh

# Ensure tracker is stopped
/etc/osso-af-init/tracker.sh stop

# Remove content databases
rm -rf /home/user/.cache/tracker/

# Remove user databases, logs and lock files
rm -rf /home/user/.local/share/tracker/

# Remove the configuration (recreated on next start)
rm -rf /home/user/.config/tracker/

# Remove all thumbnails created
rm -rf /home/user/.thumbnails/
