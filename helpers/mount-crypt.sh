#!/bin/bash

if [ $# -ne 3 ]; then
  printf "Usage: %s DEV NAME DIR\n" "${0}"
  exit 1
fi

cryptsetup luksOpen "${1}" "${2}" \
  && mkdir -p "${3}" \
  && mount /dev/mapper/"${2}" "${3}"
