#!/bin/bash

if [ $# -ne 2 ]; then
  printf "Usage: %s URL SETTINGS\n" "${BASH_SOURCE[0]}"
  exit 1
fi

declare -r BAK="${2}.bak"
cp "${2}" "${BAK}"
jq -M ".[\"default-trackers\"] |= \"$(curl "${1}")\"" < "${BAK}" > "${2}"
