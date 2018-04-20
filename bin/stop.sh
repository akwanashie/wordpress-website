#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../../.env"

OPTION=$1
if [ "$OPTION" = "hard" ]; then
  echo "Sorry also deleting the data..."
  cd $DIR/../ && docker-compose -p $APP_NAME down -v
else
  cd $DIR/../ && docker-compose -p $APP_NAME down
fi