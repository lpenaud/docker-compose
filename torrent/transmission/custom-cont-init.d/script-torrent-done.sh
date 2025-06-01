#!/bin/bash

# Not calling by transmission then pass
if [ -z "${TR_TORRENT_HASH}" ]; then
  exit 0
fi

printf '{"labels":"%s","name":"%s"}' \
  "${TR_TORRENT_LABELS}" \
  "${TR_TORRENT_NAME}" > "/downloads/done/${TR_TORRENT_HASH}.json"  
