ARG IMAGE_VERSION=31
FROM nextcloud:${IMAGE_VERSION}-fpm-alpine

ENV NEXTCLOUD_UPDATE=1

RUN apk add --no-cache ffmpeg nodejs npm

ADD config/*.config.php /var/www/html/config
