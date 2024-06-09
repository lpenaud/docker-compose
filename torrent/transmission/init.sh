#!/bin/bash

declare -r settings="$(cat /config/settings.json)"
declare -a values

# NAME VALUE
function jq_expr () {
  if [ $# -lt 2 ]; then
    return 0
  fi
  printf '.["%s"]="%s"' "${1}" "${2}"
  while shift 2 && [ $# -ge 2 ]; do
    printf ' | .["%s"]="%s"' "${1}" "${2}"
  done
  return 0
}

values+=("peer-port" "$(cat /protonvpn-port/protonvpn-port)")
if [ -n "${TRACKERS_URL}" ]; then
  values+=("default-trackers" "$(curl "${TRACKERS_URL}")")
fi

echo "${settings}" | jq "$(jq_expr "${values[@]}")" > /config/settings.json

