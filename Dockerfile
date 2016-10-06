FROM nginx:1.11-alpine

COPY default.template /etc/nginx/conf.d/default.template
ADD global /etc/nginx/global/

ENV SERVER_NAME ${SERVER_NAME:-localhost}
ENV PHP_FPM_SOCK ${PHP_FPM_SOCK:-9000}
ENV HTTP_PORT ${HTTP_PORT:-80}

CMD envsubst '\$PHP_FPM_SOCK \$SERVER_NAME \$HTTP_PORT' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf \
    && nginx -g 'daemon off;'
