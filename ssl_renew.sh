#!/bin/bash

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"
DIR="<YOUR_DIR_HERE>"

cd $DIR
$COMPOSE run --no-deps certbot renew && $COMPOSE kill -s SIGHUP nginx
$DOCKER system prune -af
