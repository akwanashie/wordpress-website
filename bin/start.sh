#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../../.env"

cd $DIR/../ && docker-compose -p $APP_NAME up -d