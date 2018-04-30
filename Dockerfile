# Pull base image.
FROM debian:stretch-slim

MAINTAINER Omar Davila <omar@zinobe.com>

ENV PUID=33
ENV PGID=33
ENV COMPOSER_HASH='544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'

ENV WORKDIR=/home/dws

VOLUME '/config'

WORKDIR $WORKDIR

# Install Nginx y PHP 7.1.
RUN apt-get update; \
    apt-get install -y \
        apt-transport-https lsb-release ca-certificates \
        wget \
        sudo \
        lsb-release

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list; \
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
  php7.1-zip \
  php7.1-gd

# Add www-data to sudoers
RUN echo "www-data	ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nginx

# Add config files
ADD ./config/fpm-php.ini /config/fpm-php.ini
ADD ./config/fpm.conf /config/fpm.conf

# Symbolic link config
RUN ln -sf /config/fpm-php.ini /etc/php/7.1/fpm/php.ini
RUN ln -sf /config/fpm.conf /etc/php/7.1/fpm/pool.d/www.conf

ADD ./entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN ln -s /usr/local/bin/entrypoint.sh /entrypoint.sh

# Start php7.1-fpm
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
