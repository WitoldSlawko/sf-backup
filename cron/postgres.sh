#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/ext/backup/functions

TMP="`local_backup_directory`"
DEST="$TMP/daily"

cd /tmp

if [ -x /usr/bin/psql ] && [ -x /usr/bin/pg_dump ]; then
	dbs=`sudo -u postgres psql -l -q 2>/dev/null |awk "{ print \\$1 }" |grep ^[a-zA-Z] |grep -v ^List$ |grep -v ^Name$ |grep -v ^template[0-9]$`
	for db in $dbs; do
		fname=`add_backup_extension postgres-$db.sql`
		sudo -u postgres pg_dump -c $db |`stream_handler` >$TMP/$fname
		mv -f $TMP/$fname $DEST/$fname 2>/dev/null
	done
fi
