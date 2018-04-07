#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../../.env"
if [ -z ${APP_NAME+x} ]; then
    echo "Could not load required environment variables. Check that it is found in $DIR/../../.env"
    exit 1
fi

DB_VOLUME_DATA=/var/lib/mysql
DB_BACKUP_FILE=mysql-backup-$(date +"%Y-%m-%d-%H:%M").tar.gz

SERVER_VOLUME_DATA=/var/www/html
SERVER_BACKUP_FILE=server-backup-$(date +"%Y-%m-%d-%H:%M").tar.gz

if [ ! -f $DB_BACKUP_FILE ]; then
    docker run --rm --volumes-from $DB_NAME -v $(pwd):/backup busybox tar -czf /backup/$DB_BACKUP_FILE $DB_VOLUME_DATA
    docker run --rm --volumes-from $SERVER_NAME -v $(pwd):/backup busybox tar -czf /backup/$SERVER_BACKUP_FILE $SERVER_VOLUME_DATA
    aws s3 cp $DB_BACKUP_FILE s3://$APP_NAME/wordpress/db/$DB_BACKUP_FILE
    aws s3 cp $SERVER_BACKUP_FILE s3://$APP_NAME/wordpress/server/$SERVER_BACKUP_FILE
fi

rm -f $DB_BACKUP_FILE
rm -f $SERVER_BACKUP_FILE