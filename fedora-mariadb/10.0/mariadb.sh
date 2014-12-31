#!/bin/sh
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null

#mysqld_safe --user mysql &
#sleep 5s

#mysql -v < /mariadb.sql
#sleep 5s

#ps -wef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9

#mysqld_safe --user mysql

#####

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MariaDB service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done


PASS=${MARIADB_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MARIADB_PASS} ] && echo "preset" || echo "random" )
echo "=> Creating MariaDB admin user with ${_word} password"

mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MariaDB Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MariaDB user 'root' has no password but only allows local connections"
echo "========================================================================"

mysqladmin -uroot shutdown