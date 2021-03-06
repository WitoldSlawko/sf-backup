#!/bin/sh
. /opt/farm/ext/backup/functions

TMP="`/opt/farm/config/get-local-backup-directory.sh`"
DEST="$TMP/daily"

for D in `/opt/farm/ext/backup/fs/detect.sh`; do
	if [ "$D" != "$TMP" ] && [ ! -f $D/.nobackup ] && [ ! -f $D/.weekly ]; then
		backup_directory $TMP $DEST $D
	fi
done
