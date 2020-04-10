DOCKER="$(which docker)"
DIR="<YOUR DIR HERE>"
VOLUMES="-v $DIR/certs:/etc/letsencrypt -v certbot-var:/var/lib/letsencrypt -v web-root:/var/www/html"
EMAIL="<YOUR EMAIL HERE>"
DOMAINS="-d <YOUR DOMAINS HERE>"

cd $DIR
$DOCKER run --rm $VOLUMES certbot/certbot certonly --webroot --webroot-path=/var/www/html --email $EMAIL --agree-tos --no-eff-email --force-renew $DOMAINS
