FROM fedora:20

# THX to theLex aka Alexander Miehe <alexander.miehe@gmail.com>
MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

WORKDIR /tmp

# Expose environment variables - but yum-like there is no specific patch, only latest minor versions based on repo
# current version of php-fpm: 5.6.4 (since 2014-12-17)
# ENV PHP_VERSION 5.6.4

RUN yum install -y wget \
    && wget http://rpms.famillecollet.com/remi-release-20.rpm \
    && yum install -y remi-release-20.rpm \
    && wget http://rpms.famillecollet.com/RPM-GPG-KEY-remi \
    && rpm --import RPM-GPG-KEY-remi \
    && sed -i 's|enabled=0|enabled=1|g' /etc/yum.repos.d/remi.repo \
    && sed -i 's|enabled=0|enabled=1|g' /etc/yum.repos.d/remi-php56.repo \
    && yum install -y php-fpm php-intl php-mbstring php-opcache git \
    && yum -y clean all \
    && sed -i '/^listen = /clisten = 0.0.0.0:9000' /etc/php-fpm.d/www.conf \
    && sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php-fpm.d/www.conf \
    && sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php-fpm.d/www.conf \
    && sed -i '/^user =/cuser = apache' /etc/php-fpm.d/www.conf \
    && sed -i '/^group =/cgroup = apache' /etc/php-fpm.d/www.conf

ADD php.ini /etc/php.d/99-custom.ini

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

VOLUME ["/var/log/php-fpm", "/root/.composer"]

EXPOSE 9000

CMD ["php-fpm", "-F"]
