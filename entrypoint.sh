#!/bin/bash

#################################
#           Omar Davila			#
#       omardavila64@gmail.com 	#
#################################

service php7.1-fpm start

usermod -u $PUID www-data
groupmod -g $PGID www-data

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === $COMPOSER_HASH) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit; } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

exec "$@"