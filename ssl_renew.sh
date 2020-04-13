DOCKER="$(which docker)"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v $DIR/var:/var/lib/letsencrypt -v $DIR/root:/var/www/html"
# TODO: change this to fit your needs
STACK_NAME="$(cat stack_name.txt)"
NETWORK_NAME="$(STACK_NAME)_in_docker"
SERVICE_NAME="$(STACK_NAME)_nginx"

cd $DIR
$DOCKER container run --rm $VOLUMES --network in_docker_in_docker certbot/certbot renew && \
    $DOCKER service update --force --stop-signal SIGHUP $SERVICE_NAME