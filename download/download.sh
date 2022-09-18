#!/bin/bash

declare -r DEFAULT_COUNTRY="${DOWNLOAD_COUNTRY:-FR}"
declare -r -i DEFAULT_END_INDEX="${DOWNLOAD_END_INDEX:-21}" \
  DEFAULT_START_INDEX="${DOWNLOAD_START_INDEX:-84}" \
  DEFAULT_TIMEOUT="${DOWNLOAD_TIMEOUT:-1}"
declare -a urls
declare -i n \
  end_index="${DOWNLOAD_END_INDEX}" \
  start_index="${DOWNLOAD_START_INDEX}" \
  timeout="${DEFAULT_TIMEOUT}"
declare -u country="${DEFAULT_COUNTRY}"
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

function usage () {
  printf "Usage: %s [OPTIONS] [URL...]\n" "${0}"
  echo "DESCRIPTION"
  echo "  Download files with plowdown."
  echo "  Change the VPN connexion just before to download."
  printf "  Server type: COUNTRY#INDEX for example: %s#%d.\n" \
    "${DEFAULT_COUNTRY}" \
    "${DEFAULT_START_INDEX}"
  echo "OPTIONS"
  printf "  (-e --end-index)    Specify the end index (by default: %d)\n" "${DEFAULT_END_INDEX}"
  printf "  (-c --country)      Specify the server country (by default: %s)\n" "${DEFAULT_COUNTRY}"
  printf "  (-s --start-index)  Specify the start index (by default: %d)\n" "${DEFAULT_START_INDEX}"
  printf "  (-t --timeout)      Specify Plowdown timeout (by default: %d)\n" "${DEFAULT_TIMEOUT}"
  printf "  (-h --help)         Display this message\n"
  exit "${1}"
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
    -e | --end-index)
      end_index="${2}"
      (( n++ ))
      ;;
    -c | --country)
      country="${2}"
      (( n++ ))
      ;;
    -h | --help)
      usage 0
      ;;
    -s | --start-index)
      start_index="${2}"
      (( n++ ))
      ;;
    -t | --timeout)
      timeout="${2}"
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
  usage 1 >&2
fi

main "${urls[@]}"
