#!/bin/bash
#
# Backup Nextcloud files and db.
# Global:
#  BACKUP_DIR
#  POSTGRES_DB
#  POSTGRES_USER

function load_env_file () {
  local env_file
  local -l error=n
  # If absolute pathname
  if [[ "${1}" =~ ^/ ]]; then
    env_file="${1}"
  else
    env_file="$(dirname "${BASH_SOURCE[0]}")/${1:-.env}"
  fi
  source "${env_file}"
  if [ -z "${BACKUP_DIR}" ]; then
    echo "ERROR: BACKUP_DIR empty" >&2
    error=y
  fi
  if [ -z "${POSTGRES_DB}" ]; then
    echo "ERROR: POSTGRES_DB empty" >&2
    error=y
  fi
  if [ -z "${POSTGRES_USER}" ]; then
    echo "ERROR: POSTGRES_USER empty" >&2
    error=y
  fi
  if [ "${error}" = y ]; then
    exit 1
  fi
}

load_env_file "${1}"

declare -r BAK_DIR="${BACKUP_DIR}/$(date -I)"
declare -r NC_USER="www-data" NC_CONTAINER="nextcloud" NC_BAK="${BAK_DIR}/nextcloud-dirbkp"
declare -r PG_CONTAINER="nextcloud_pg" PG_BAK="${BAK_DIR}/pg.bak"

mkdir -p "${BAK_DIR}"

# Activate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --on

# Backup database
docker exec "${PG_CONTAINER}" pg_dump "${POSTGRES_DB}" -U "${POSTGRES_USER}" > "${PG_BAK}" &

docker cp -a "${NC_CONTAINER}:/var/www/html" "${NC_BAK}" &

# Wait for all tasks
wait

# Desactivate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --off
