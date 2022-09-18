#!/bin/bash

if [ $# -ne 2 ]; then
  printf "Usage: %s DIR NAME\n" "${0}"
  exit 1
fi

umount "${1}" && cryptsetup luksClose "${2}"
