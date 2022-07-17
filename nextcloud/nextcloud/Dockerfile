ARG IMAGE_VERSION
FROM nextcloud:${IMAGE_VERSION}-fpm-alpine

ENV NEXTCLOUD_UPDATE=1

RUN apk add --no-cache supervisor ffmpeg imagemagick \
  && docker-php-ext-enable imagick \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
