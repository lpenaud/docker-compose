#!/bin/bash

# Exit on failure
set -e

# expression backup outfile
function jq::safe () {
  local expr="${1}" backup="${2}" outfile="${3}"
  # If json is valid then commit
  if jq -e "${expr}" < "${backup}" > "${outfile}"; then
    cp "${outfile}" "${backup}"
    return 0
  fi
  # Else rollback
  cp "${backup}" "${outfile}"
  return 1
}

declare -r settings="/config/settings.json" bak="/config/settings.bak.json"
declare jq_expr

# Backup settings
cp "${settings}" "${bak}"

if [ -n "${TRACKERS_URL}" ]; then
  printf -v jq_expr '.["default-trackers"]="%s"' "$(curl -s "${TRACKERS_URL}")"
  jq::safe "${jq_expr}" "${bak}" "${settings}"
fi

if [ -n "${TORRENT_DONE}" ]; then
  printf -v jq_expr '.["script-torrent-done-enabled"]=true | .["script-torrent-done-filename"]="%s"' \
    "${TORRENT_DONE}"
else
  printf -v jq_expr '.["script-torrent-done-enabled"]=false'
fi
jq::safe "${jq_expr}" "${bak}" "${settings}"
