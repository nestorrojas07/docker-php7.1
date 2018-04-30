#!/bin/bash

#################################
#           Omar Davila			#
#       omardavila64@gmail.com 	#
#################################

service php7.1-fpm start

# Change UserID
usermod -u $PUID www-data
groupmod -g $PGID www-data

# Change home permissions
chown -R www-data.www-data $WORKDIR

# Change home
usermod -d $WORKDIR www-data

# Change bash
usermod -s /bin/bash www-data

sudo -u www-data php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo -u www-data php -r "if (hash_file('SHA384', 'composer-setup.php') === $COMPOSER_HASH) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit; } echo PHP_EOL;"
sudo -u www-data php composer-setup.php
sudo -u www-data php -r "unlink('composer-setup.php');"

sudo -u www-data chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# Install PHP code sniffer
sudo -u www-data composer global require "squizlabs/php_codesniffer=*"

# Link to phpcs
ln -sf $WORKDIR/.composer/vendor/bin/phpcs /usr/local/bin/phpcs

su - www-data

exec "$@"