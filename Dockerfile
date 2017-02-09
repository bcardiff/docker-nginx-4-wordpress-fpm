FROM nginx:1.11-alpine

COPY default.template /etc/nginx/conf.d/default.template
ADD global /etc/nginx/global/

ENV SERVER_NAME ${SERVER_NAME:-localhost}
ENV PHP_FPM_SOCK ${PHP_FPM_SOCK:-9000}
ENV HTTP_PORT ${HTTP_PORT:-80}
ENV CLIENT_MAX_BODY_SIZE ${CLIENT_MAX_BODY_SIZE:-'2m'}

CMD envsubst '\$PHP_FPM_SOCK \$SERVER_NAME \$HTTP_PORT \$CLIENT_MAX_BODY_SIZE' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf \
    && nginx -g 'daemon off;'
