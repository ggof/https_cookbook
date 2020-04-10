#! /usr/bin/env sh

mkdir var && mkdir dhparams && mkdir certs && mkdir root

sudo openssl dhparam -out $(pwd)/dhparams/dhparam-2048.pem 2048
