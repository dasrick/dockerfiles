FROM phusion/baseimage:0.9.16

MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose environment variables
ENV BAMBOO_VERSION 5.7.2
ENV BAMBOO_HOME /opt/bamboo-home
ENV BAMBOO_SRC /opt

# Expose web and agent ports
EXPOSE 8085
EXPOSE 54663

# Add service for auto run
ADD bamboo-server.sh /etc/service/bamboo-server/run
RUN chmod +x /etc/service/bamboo-server/run

# Make sure we get latest packages
RUN apt-get update && apt-get upgrade -y

# Install Java OpenJDK 7 and VCS tools
RUN apt-get install -yq python-software-properties && add-apt-repository ppa:webupd8team/java -y && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -yq oracle-java7-installer git

# clean up the system
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p $BAMBOO_HOME
VOLUME [$BAMBOO_HOME]