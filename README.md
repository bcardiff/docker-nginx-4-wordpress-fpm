# nginx-4-wordpress-fpm

`nginx-4-wordpress-fpm` docker images complements `wordpress:*-fpm` [official images](https://hub.docker.com/_/wordpress/). Apache alternatives serves http request. In order to allow PHP-fpm serve http request a webserver is needed (nginx).

This image uses `PHP_FPM_SOCK` environment variable to customize the location of the socket (usually port 9000 of php-fpm container).

This image serves the static files directly without going to the wordpress container.

This image is prepared to work with [nginx-cache](https://wordpress.org/plugins/nginx-cache/) wordpress plugin using `/data/nginx/cache` as **cache zone path**.
The plugin running in the wordpress container will remove the `/data/nginx/cache` directory cleaning up the cache for the nginx running in the `nginx-4-wordpress-fpm` container.

Note that both container need to share cache and html volumes.

Following, a `docker-compose.yml` that prepares a ready to use wordpress installation.

```
version: '2.0'

services:
  mysql:
    image: 'mysql:5.7'
    environment:
      - MYSQL_ROOT_PASSWORD=secret

  php-fpm:
    image: wordpress:4.6-fpm
    environment:
      - WORDPRESS_DB_USER=root
      - WORDPRESS_DB_PASSWORD=secret
    volumes:
      - './data/html:/var/www/html'
      - './data/nginx:/data/nginx'

  web:
    image: bcardiff/nginx-4-wordpress-fpm
    environment:
      - PHP_FPM_SOCK=php-fpm:9000
    ports:
      - 8080:80
    volumes:
      - './data/html:/var/www/html'
      - './data/nginx:/data/nginx'
```
