#! /usr/bin/env sh
DOCKER="$(which docker)"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v $DIR/var:/var/lib/letsencrypt -v $DIR/root:/var/www/html"
EMAIL="<YOUR EMAIL HERE>"
DOMAINS="-d <YOUR DOMAINS HERE>"
# TODO: change this to fit your needs
STACK_NAME="$(cat stack_name.txt)"
NETWORK_NAME="$(STACK_NAME)_in_docker"
SERVICE_NAME="$(STACK_NAME)_nginx"

cd $DIR
$DOCKER container run --rm $VOLUMES --network $NETWORK_NAME certbot/certbot certonly --webroot --webroot-path=/var/www/html --email $EMAIL --agree-tos --no-eff-email --force-renew $DOMAINS && \
    $DOCKER service update --force --stop-signal SIGHUP $SERVICE_NAME