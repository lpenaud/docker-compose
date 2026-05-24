# Docker-compose

Some useful docker-compose.

## Torrent

Use Proton VPN to share some files in P2P with the BitTorrent client Transmission.

Credits:

-[qdm12/gluetun](https://github.com/passteque/gluetun)
- [linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission)
- [ngosang/trackerslist](https://github.com/ngosang/trackerslist)

I use [tremotesf-android](https://github.com/equeim/tremotesf-android) on my phone to control remotely Transmission.

Transmission doc: https://github.com/transmission/transmission/blob/main/docs

Gluetun-wiki links:

- [Healthcheck](https://github.com/qdm12/gluetun-wiki/blob/main/faq/healthcheck.md#healthcheck)
- [VPN server port forwarding](https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/vpn-port-forwarding.md)
- [VPN servers](https://github.com/qdm12/gluetun-wiki/blob/main/setup/servers.md#update-using-the-command-line)

## Nextcloud

Initialise nextcloud and all needed services for its execution.

Configuration freely inspired by the [examples](https://github.com/nextcloud/docker/tree/master/.examples) given by nextcloud.

Credits:

- [Postgres](https://hub.docker.com/_/postgres)
- [Redis](https://hub.docker.com/_/redis/)
- [Nextcloud](https://hub.docker.com/_/nextcloud/)
- [Nextcloud cron](https://github.com/nextcloud/docker/tree/master/.examples/dockerfiles/cron/fpm-alpine)
- [Nginx](https://hub.docker.com/_/nginx/)
