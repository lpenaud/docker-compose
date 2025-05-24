ARG WIREGUARD_VERSION=latest
FROM lscr.io/linuxserver/wireguard:${WIREGUARD_VERSION}

RUN apk --no-cache add libnatpmp

RUN mkdir /custom-services.d
ADD --chown=root:root --chmod=755 ./custom-services.d/*.sh /custom-services.d

VOLUME /protonvpn-port
