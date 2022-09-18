#!/bin/bash

declare -a args

args+=(run)
args+=(--env-file .env)
if [ -n "${1}" ]; then
  args+=(--volume "${1}:/Downloads")
fi
args+=(--name plowshare)
args+=(--device=/dev/net/tun)
args+=(--cap-add=NET_ADMIN)
args+=(--detach)
args+=(plowshare)

echo "${args[@]}"
docker "${args[@]}"
