#! /usr/bin/env sh

DOCKER=$(which docker)

mkdir var && mkdir dhparams && mkdir certs && mkdir root

sudo openssl dhparam -out $(pwd)/dhparams/dhparam-2048.pem 2048

$DOCKER swarm init

$DOCKER stack deploy --compose-file stack.yml $(cat stack_name.txt)
