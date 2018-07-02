#!/bin/sh
. /opt/farm/scripts/functions.custom
. /opt/farm/ext/db-utils/functions.mysql
. /opt/farm/ext/backup/functions
. /opt/farm/ext/keys/functions

TMP="`local_backup_directory`"
DEST="$TMP/daily"

warn="Using a password"
user=`mysql_local_user`

if [ "$user" != "" ]; then
	port=`mysql_local_port`
	pass=`mysql_local_password`

	if [ -f /etc/mysql/.nolock ]; then
		backup_mysql 127.0.0.1 $port $user $pass mysql $TMP $DEST skip 2>&1 |grep -v "$warn"
	else
		backup_mysql 127.0.0.1 $port $user $pass mysql $TMP $DEST 2>&1 |grep -v "$warn"
	fi
fi
