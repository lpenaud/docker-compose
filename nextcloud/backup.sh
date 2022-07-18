#!/bin/bash

declare -r NC_USER='www-data' NC_CONTAINER='nextcloud'
declare -r PG_

# Activate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --on

# Desactivate maintenance mode
docker exec -u "${NC_USER}" "${NC_CONTAINER}" ./occ maintenance:mode --off
