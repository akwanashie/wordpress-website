## HOKRAS Wordpress

### Setup

- Create a `.env` file in parent directory (i.e. `../`) with the following variables

```
export APP_NAME=
export DB_NAME=
export SERVER_NAME=

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

export MYSQL_ROOT_PASSWORD=
export MYSQL_DATABASE=
export MYSQL_USER=
export MYSQL_PASSWORD=

export WP_USER=
export WP_PASSWORD=
export WP_EMAIL=
```

- Create an S3 bucket with the APP_NAME and grant appropriate read/write permissions

**Start**

```
  ./bin/start.sh
```

**Stop**

```
  ./bin/stop.sh
```

**Stop and clean data**

```
  ./bin/stop.sh hard
```

**Backup**

```
  ./bin/start.sh && ./bin/backup.sh
```

**Restore**

```
  ./bin/reload.sh hard && ./bin/restore.sh && ./bin/reload.sh
```

### Notes
- [Transfer wordpress website from docker to webhost](http://www.wpexplorer.com/migrating-wordpress-website/)