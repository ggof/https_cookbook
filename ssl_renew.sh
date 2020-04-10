DOCKER="$(which docker) container"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v $DIR/var:/var/lib/letsencrypt -v $DIR/root:/var/www/html"

cd $DIR
$DOCKER run --rm $VOLUMES --network in_docker_in_docker certbot/certbot renew
