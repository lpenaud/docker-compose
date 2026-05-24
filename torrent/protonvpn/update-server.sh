#!/bin/bash
# Update proton vpn server list.
# See: https://github.com/qdm12/gluetun-wiki/blob/main/setup/servers.md

declare -r FILENAME="$(realpath "${0}")"
declare -r DIRNAME="$(dirname "${FILENAME}")"

declare email password

read -p "Proton email: " email
read -s -p "Proton password: " password
docker run --rm -v "${DIRNAME}/gluetun:/gluetun" \
  qmcgaw/gluetun \
  update \
  -enduser \
  -providers protonvpn \
  -proton-email "${email}" \
  -proton-password "${password}"
