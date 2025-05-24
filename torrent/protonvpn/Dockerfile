ARG WIREGUARD_VERSION=latest
FROM lscr.io/linuxserver/wireguard:${WIREGUARD_VERSION}

RUN apk --no-cache add libnatpmp

RUN mkdir /custom-cont-init.d
ADD --chmod=root:root --chown=755 ./custom-cont-init.d/*.sh /custom-cont-init.d

