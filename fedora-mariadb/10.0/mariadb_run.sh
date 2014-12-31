#!/bin/bash

# script ist taken from
# https://github.com/tutumcloud/tutum-docker-mariadb

VOLUME_HOME="/data"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing MariaDB ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /mariadb_init.sh
else
    echo "=> Using an existing volume of MariaDB"
fi

exec mysqld_safe