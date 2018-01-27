# Pull base image.
FROM ubuntu:17.10

MAINTAINER Omar Davila <omar@zinobe.com>

ENV PUID=33
ENV PGID=33

ENV WORKDIR=/home/dws

WORKDIR $WORKDIR

# Install Nginx y PHP 7.1.
RUN apt-get update; \
  apt-get install -y software-properties-common; \
  apt-get install -y python-software-properties; \
  add-apt-repository -y ppa:ondrej/php; \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C; \
  apt-get update

RUN apt-get install -y \
  php7.1 \
  php7.1-fpm \
  php7.1-pdo \
  php7.1-mysql \
  php7.1-mbstring \
  php7.1-soap \
  php7.1-json \
  php7.1-curl \
  php7.1-xml \
  php7.1-zip

# Add config files
ADD config/fpm-php.ini /etc/php/7.1/fpm/php.ini
ADD config/fpm.conf /etc/php/7.1/fpm/pool.d/www.conf

ADD --chown=root:root ./entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN ln -s /usr/local/bin/entrypoint.sh /entrypoint.sh

# Start php7.1-fpm
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
