#!/bin/bash

# script ist taken from
# https://github.com/tutumcloud/tutum-docker-mariadb

/usr/bin/mysqld_safe > /dev/null 2>&1 &

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


#mysql -uroot -e "UPDATE mysql.user SET Password = PASSWORD('$PASS') WHERE User = 'admin'"
mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"
mysql -uroot -e "DROP USER ''@'localhost'"
mysql -uroot -e "DROP USER ''@'$HOSTNAME'"
mysql -uroot -e "DELETE FROM mysql.db WHERE Db LIKE 'test%'"
mysql -uroot -e "DROP DATABASE test"
mysql -uroot -e "FLUSH PRIVILEGES"

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