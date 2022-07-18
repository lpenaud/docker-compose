#!/bin/bash
#
# Backup Nextcloud files and db.
# Global:
#  BACKUP_DIR
#  POSTGRES_DB
#  POSTGRES_USER

declare -r NC_USER='www-data' NC_CONTAINER='nextcloud'
declare -r PG_CONTAINER='nextcloud_pg' PG_BAK="pg/$(date +"%Y.%m.%d-%H.%M").bak"

# Activate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --on

docker exec "${PG_CONTAINER}" pg_dump "${POSTGRES_DB}" -U "${POSTGRES_USER}" > "${PG_BAK}"

# Desactivate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --off
