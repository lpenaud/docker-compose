ARG PROTONVPN_VERSION=latest
FROM ghcr.io/tprasadtp/protonvpn:${PROTONVPN_VERSION}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y iputils-ping
