#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/../../.env"
if [ -z ${APP_NAME+x} ]; then
    echo "Could not load required environment variables. Check that it is found in $DIR/../../.env"
    exit 1
fi

DB_BACKUP_FILE=$(aws s3 ls ${APP_NAME}/wordpress/db/ | sort | tail -n 1 | awk '{print $4}')
aws s3 cp s3://${APP_NAME}/wordpress/db/$DB_BACKUP_FILE .
docker run --rm --volumes-from $DB_NAME -v $(pwd):/backup busybox tar xvf /backup/$DB_BACKUP_FILE

SERVER_BACKUP_FILE=$(aws s3 ls ${APP_NAME}/wordpress/server/ | sort | tail -n 1 | awk '{print $4}')
aws s3 cp s3://${APP_NAME}/wordpress/server/$SERVER_BACKUP_FILE .
docker run --rm --volumes-from $SERVER_NAME -v $(pwd):/backup busybox tar xvf /backup/$SERVER_BACKUP_FILE

rm -f $DB_BACKUP_FILE
rm -f $SERVER_BACKUP_FILE