#!/bin/bash

declare -r settings="$(cat /config/settings.json)"
declare jq_expr

jq_expr=".[\"peer-port\"]=$(cat /protonvpn-port/protonvpn-port)"
if [ -n "${TRACKERS_URL}" ]; then
  jq_expr+=" | .[\"default-trackers\"]=\"$(curl "${TRACKERS_URL}")\""
fi
if [ -n "${TORRENT_DONE}" ]; then
  jq_expr+=" | .[\"script-torrent-done-enabled\"]=true"
  jq_expr+=" | .[\"script-torrent-done-filename\"]=\"${TORRENT_DONE}\""
else
  jq_expr+=" | .[\"script-torrent-done-enabled\"]=false"
fi

echo "${settings}" | jq "${jq_expr}" > /config/settings.json

