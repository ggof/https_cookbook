### INITIAL SETUP
To use this docker-compose, please read the instructions first.
The configurations needed are not what you could call "straightforward",
and you might need some tinkering. Here are the steps to start this 
repository from scratch : 

- First, open the nginx conf from `nginx/nginx.conf`. comment the `server` 
block that handles port 443. Save and exit.
- Second, open `docker-compose.yml` and modify the `certbot` entry. 
You will need to modify the `command` to use the following instead : 
```bash
certonly --webroot --webroot-path=/var/www/html --email <your email> --agree-tos --no-eff-email --staging -d <domain name> -d <domain name> <...>
```
- Run the docker-compose file and get the output logs from `certbot` with
```bash
docker-compose up -d
docker-compose logs certbot
```
- If all went well, you are now ready for the next step.
- Modify the `command` portion of `docker-compose.yml` again to replace the `--staging` with `--force-renewal` option.
- run 
```bash
docker-compose up --force-recreate --no-deps certbot
```
This wil run certbot (which will create your certificates) without breaking 
the existing containers.
- Once this is done, you should have HTTPS certificates. You now need to enable 
the HTTPS config in `nginx/nginx.conf`.
- Open `nginx/nginx.conf` and uncomment the `server` block that handles port 443. Save and exit.
- Reload your nginx instance with 
```bash
docker-compose kill -s SIGHUP nginx
```
- Register the `ssl_renew.sh` script in `cron`. To do that, run 
```bash
sudo crontab -e
```
Then, append this to the bottom of the file :
```bash
0 12 * * * /path/to/your/repo/ssl_renew.sh >> /var/log/cron.log 2>&1
```

---

And that's it, you're good to go! you should now have an HTTPS-enabled project!

