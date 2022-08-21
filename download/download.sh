#!/bin/bash

declare -a urls
declare -i n timeout=1 \
  start_index="${DOWNLOAD_START_INDEX}" \
  end_index="${DOWNLOAD_END_INDEX}"
declare -u country="${DOWNLOAD_COUNTRY}"
declare url

function add_url () {
  if [[ "${1}" =~ ^https? ]]; then
    urls+=("${1}")
    return 0
  fi
  echo "Ignore '${1}'" >&2
  return 1
}

function vpn_download () {
  protonvpn c "${country}#${2}"
  plowdown -t "${timeout}" "${1}"
}

function main () {
  local -i index="${start_index}"
  while [ $# -ne 0 ]; do
    vpn_download "${1}" "${index}"
    n=$?
    (( index++ ))
    if [ "${index}" -gt "${end_index}" ]; then
      index="${start_index}"
    fi
    # If server already use
    # Retry with other connexion
    if [ "${n}" -ne 5 ]; then
      shift
    fi
  done
}

while [ $# -ne 0 ]; do
  n=1
  case "${1}" in
    -t | --timeout)
      timeout="${2}"
      (( n++ ))
      ;;
    -c | --country)
      country="${2}"
      (( n++ ))
      ;;
    -s | --start-index)
      start_index="${2}"
      (( n++ ))
      ;;
    -e | --end-index)
      end_index="${2}"
      (( n++ ))
      ;;
    *)
      if [ -f "${1}" ]; then
        while read -e url; do
          add_url "${url}"
        done < "${1}"
      else
        add_url "${1}" 
      fi
      ;;
  esac
  shift $n
done

if [ "${#urls[@]}" -eq 0 ]; then
  echo "ERROR: No url provided" >&2
  echo "Usage: ${0} [URL...] [FILE...]" >&2
  exit 1
fi

main "${urls[@]}"
