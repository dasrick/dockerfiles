FROM dockerfile/ubuntu

MAINTAINER Enrico Hoffmann <dasrick@gmail.com>

# Expose environment variables
ENV NGINX_VERSION 1.7.9

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx=${NGINX_VERSION} && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Define mountable directories
VOLUME ["/var/www", "/var/log/nginx", "/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]

# Expose the ports
EXPOSE 80:80 443:443

# Define default command
CMD ["nginx"]