# nginx-4-wordpress-fpm

`nginx-4-wordpress-fpm` docker images complements `wordpress:*-fpm` [official images](https://hub.docker.com/_/wordpress/). Apache alternatives serves http request. In order to allow PHP-fpm serve http request a webserver is needed (nginx).

This image uses the following environment variables:
 * `PHP_FPM_SOCK` to customize the location of the upstream php-fpm socket (defaults to `9000`).
 * `SERVER_NAME` to set the hostname that nginx will listen on (defaults to `localhost`).
 * `HTTP_PORT` to set the port that nginx will listen on (defaults to `80`)
 * `CLIENT_MAX_BODY_SIZE` to set the maximum body size of the POST (defaults to `2m`)


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

  web:
    image: bcardiff/nginx-4-wordpress-fpm
    environment:
      - PHP_FPM_SOCK=php-fpm:9000
    ports:
      - 8080:80
    volumes:
      - './data/html:/var/www/html'
```
