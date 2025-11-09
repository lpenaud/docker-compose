#!/bin/bash

# Init calling
if [ -z "${TR_TORRENT_HASH}" ]; then
  mkdir -p "/downloads/done"
  exit
fi

# Transmission after done torrent calling
# Variables: https://github.com/transmission/transmission/blob/main/docs/Scripts.md#on-torrent-completion
cat <<EOF > "/downloads/done/${TR_TORRENT_NAME}.${TR_TORRENT_HASH}.json"
{
  "version": "${TR_APP_VERSION}",
  "time": "${TR_TIME_LOCALTIME}",
  "downloaded": "${TR_TORRENT_BYTES_DOWNLOADED}",
  "dir": "${TR_TORRENT_DIR}",
  "hash": "${TR_TORRENT_HASH}",
  "id": "${TR_TORRENT_ID}",
  "labels": "${TR_TORRENT_LABELS}",
  "name": "${TR_TORRENT_NAME}",
  "priority": "${TR_TORRENT_PRIORITY}",
  "trackers": "${TR_TORRENT_TRACKERS}"
}
EOF
