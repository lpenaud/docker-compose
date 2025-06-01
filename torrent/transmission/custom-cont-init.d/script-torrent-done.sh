#!/bin/bash

# Init calling
if [ -z "${TR_TORRENT_HASH}" ]; then
  mkdir -p "/downloads/done"
  exit
fi

# Transmission after done torrent calling
printf '{"labels":"%s","name":"%s"}' \
  "${TR_TORRENT_LABELS}" \
  "${TR_TORRENT_NAME}" > "/downloads/done/${TR_TORRENT_HASH}.json"  
