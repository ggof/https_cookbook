#! /usr/bin/env sh
DOCKER="$(which docker)"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v $DIR/var:/var/lib/letsencrypt -v $DIR/root:/var/www/html"
EMAIL="<YOUR EMAIL HERE>"
DOMAINS="-d <YOUR DOMAINS HERE>"

cd $DIR
$DOCKER container run --rm $VOLUMES --network in_docker_in_docker certbot/certbot certonly --webroot --webroot-path=/var/www/html --email $EMAIL --agree-tos --no-eff-email --force-renew $DOMAINS
