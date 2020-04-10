DOCKER="$(which docker) container"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v certbot-var:/var/lib/letsencrypt -v web-root:/var/www/html"

cd $DIR
$DOCKER run --rm $VOLUMES certbot/certbot --renew
