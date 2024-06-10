#!/bin/bash

declare -r settings="$(cat /config/settings.json)"
declare jq_expr

jq_expr=".[\"peer-port\"]=$(cat /protonvpn-port/protonvpn-port)"
if [ -n "${TRACKERS_URL}" ]; then
  jq_expr+=" | .[\"default-trackers\"]=\"$(curl "${TRACKERS_URL}")\""
fi

echo "${settings}" | jq "${jq_expr}" > /config/settings.json

