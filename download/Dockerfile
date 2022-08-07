ARG PROTONVPN_VERSION=latest
FROM ghcr.io/tprasadtp/protonvpn:${PROTONVPN_VERSION}
ENV TZ=Europe/Paris
ENV PROTONVPN_SERVER=RANDOM

# Required for tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
  && apt-get install --yes plowshare inetutils-ping

# Modules
RUN mkdir -p ~/.config/plowshare/modules.d \
  && cd ~/.config/plowshare/modules.d \
  && curl -L -k https://github.com/mcrapet/plowshare-modules-legacy/archive/master.tar.gz | tar -C ~/.config/plowshare/modules.d -z -x -f -

# Add downlaod script
ADD ./download.sh /usr/bin/
