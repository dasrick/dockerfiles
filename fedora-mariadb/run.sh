#!/bin/bash

VOLUME_HOME="/data"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing MariaDB ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /create_admin_user.sh
else
    echo "=> Using an existing volume of MariaDB"
fi

exec mysqld_safe