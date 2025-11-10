#!/bin/bash

# Init calling
if [ -z "${TR_TORRENT_HASH}" ]; then
  mkdir -p "/downloads/done"
  exit
fi

# value
# Sometime there are value with newline T_T
# So we need this little fix.
function json::format () {
  printf "%s" "${1}"
}

# Transmission after done torrent calling
# Variables: https://github.com/transmission/transmission/blob/main/docs/Scripts.md#on-torrent-completion
cat <<EOF > "/downloads/done/${TR_TORRENT_NAME}.${TR_TORRENT_HASH}.json"
{
  "version": "$(json::format "${TR_APP_VERSION}")",
  "time": "$(json::format "${TR_TIME_LOCALTIME}")",
  "downloaded": "$(json::format "${TR_TORRENT_BYTES_DOWNLOADED}")",
  "dir": "$(json::format "${TR_TORRENT_DIR}")",
  "hash": "$(json::format "${TR_TORRENT_HASH}")",
  "id": "$(json::format "${TR_TORRENT_ID}")",
  "labels": "$(json::format "${TR_TORRENT_LABELS}")",
  "name": "$(json::format "${TR_TORRENT_NAME}")",
  "priority": "$(json::format "${TR_TORRENT_PRIORITY}")",
  "trackers": "$(json::format "${TR_TORRENT_TRACKERS}")"
}
EOF
