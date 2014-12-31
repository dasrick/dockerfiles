FROM fedora:20

MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

ADD mariadb.repo        /etc/yum.repos.d/mariadb.repo
ADD server.cnf          /etc/my.cnf.d/server.cnf
ADD mariadb_init.sh     /mariadb_init.sh
ADD mariadb_run.sh      /mariadb_run.sh

RUN yum -y update && yum -y install MariaDB-server MariaDB-client && yum clean all && chmod 775 /*.sh

VOLUME ["/data", "/var/log/mysql"]

#Added to avoid in container connection to the database with mysql client error message "TERM environment variable not set"
ENV TERM dumb

EXPOSE 3306

CMD ["/mariadb_run.sh"]