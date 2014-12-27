FROM fedora:20

MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

ENV MARIADB_VERSION 10.0.15

RUN yum -y update && yum -y install MariaDB-server MariaDB-client && yum clean all

ADD server.cnf              /etc/my.cnf.d/server.cnf
ADD create_admin_user.sh    /create_admin_user.sh
ADD run.sh                  /run.sh

RUN chmod 775 /*.sh

VOLUME ["/data", "/var/log/mysql"]

EXPOSE 3306

CMD ["/run.sh"]