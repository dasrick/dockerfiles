FROM fedora:20

MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

ADD mariadb.repo    /etc/yum.repos.d/mariadb.repo
ADD server.cnf      /etc/my.cnf.d/server.cnf

ADD mariadb.sql     /mariadb.sql
ADD mariadb.sh      /mariadb.sh

RUN yum -y update && yum -y install MariaDB-server MariaDB-client && yum clean all && chmod 775 /*.sh

VOLUME ["/data", "/var/log/mysql"]

EXPOSE 3306

CMD ["/mariadb.sh"]