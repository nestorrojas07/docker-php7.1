#!/bin/bash

#################################
#           Omar Davila			#
#       omardavila64@gmail.com 	#
#################################

service php7.1-fpm start

usermod -u $PUID www-data
groupmod -g $PGID www-data

exec "$@"