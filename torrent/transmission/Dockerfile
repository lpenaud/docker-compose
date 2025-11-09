ARG TRANSMISSION_VERSION=latest

FROM lscr.io/linuxserver/transmission:${TRANSMISSION_VERSION}

RUN mkdir -p /custom-cont-init.d /custom-services.d

ADD --chown=root:root --chmod=755 ./custom-cont-init.d/*.sh /custom-cont-init.d
ADD --chown=root:root --chmod=755 ./healthcheck.sh /healthcheck.sh
