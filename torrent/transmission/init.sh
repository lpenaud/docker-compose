#!/bin/sh

declare -r settings="$(cat /config/settings.json)"
echo "${settings}" | jq ".[\"peer-port\"]=$(cat /protonvpn-port/protonvpn-port)" > /config/settings.json
