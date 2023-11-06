ARG PROTONVPN_VERSION=latest
FROM ghcr.io/tprasadtp/protonvpn:${PROTONVPN_VERSION}

RUN apt update && \
    apt upgrade -y && \
    apt install -y iputils-ping
