#!/bin/bash

declare -r FILENAME="$(realpath "${BASH_SOURCE[0]}")"
declare -r DIRNAME="$(dirname "${FILENAME}")"

if [ $# -ne 2 ]; then
  printf "Usage: %s URL SETTINGS\n" "${BASH_SOURCE[0]}"
  exit 1
fi

declare -r BAK="${2}.bak"
cp "${2}" "${BAK}"
docker compose --project-directory "${DIRNAME}" down
jq -M ".[\"default-trackers\"] |= \"$(curl "${1}")\"" < "${BAK}" > "${2}"
docker compose --project-directory "${DIRNAME}" up -d