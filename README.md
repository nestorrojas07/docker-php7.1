## Optimized for laravel 5.x
**PHP 7.1 to Nginx**

### ENV:

* **PUID**
User ID of owner of the directory to binding. Default ** *33* (www-data user)**

* **PGID**
Group ID of owner of the directory to binding. Default ** *33* (www-data group)**

* **WORKDIR**
Docker workdir. Default: `/home/dws`

### VOLUME:
Bind projects:
- `./myproject1:/home/dws/myproject1`
- `./myproject2:/home/dws/myproject2`