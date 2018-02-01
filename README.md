## Optimized for laravel 5.x
**PHP 7.1 to Nginx**

### ENV:

* **PUID**
User ID of owner of the directory to binding. Default ***33* (www-data user)**

* **PGID**
Group ID of owner of the directory to binding. Default ***33* (www-data group)**

* **WORKDIR**
Docker workdir. Default: ```/home/dws```

### VOLUME:
php-fpm config:
- ```config:/config``` _`(optional)`_

Bind projects:
- ```myproject1:/home/dws/myproject1```
- ```myproject2:/home/dws/myproject2```
- ```myprojectN:/home/dws/myprojectN```

### RUN CONTAINER:
```bash
$ docker run -it --name php71 -v config:/config -v myproject1:/home/dws/myproject1 -e PUIG=1000 -e PGID=1000 omardavila64/php7.1:latest /bin/bash
```
