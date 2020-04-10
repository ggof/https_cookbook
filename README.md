### INITIAL SETUP
To use this docker-compose, please read the instructions first.
The configurations needed are not what you could call "straightforward",
and you might need some tinkering. Here are the steps to start this 
repository from scratch : 

- Clone this repo and `cd in_docker`.
- Create your Diffie-Hellman parameters for better security. To do that run 
```bash
mkdir dhparams && sudo openssl dhparam -out $(pwd)/dhparams/dhparam-2048.pem 2048
```
- Open the nginx conf from `nginx/nginx.conf`. This config has been 
intentionaly left generic. Modify it as you need (at least modify **ALL** 
the fields enclosed with `<>`).
- Run the docker-compose file and get the output logs from `certbot` with
```bash
docker-compose up -d
docker-compose logs certbot
```
- If all went well, you are now ready for the next step.
- Modify the `command` portion of `docker-compose.yml` again to replace 
the `--staging` option with `--force-renewal` option. Save and exit.
- Run the following command : 
```bash
docker-compose up --force-recreate --no-deps certbot
```
This wil run the certbot container (which will create your certificates) without breaking 
the existing containers.
- Once this is done, you should have HTTPS certificates. You now need to enable 
the HTTPS config in `nginx/nginx.conf`.
- Open `nginx/nginx.conf` and uncomment the `server` block that handles port 443. 
Also replace everything that is enclosed with `<>` with your own data. Save and exit.
- Reload your nginx container with : 
```bash
docker-compose kill -s SIGHUP nginx
```
- Modify the `ssl_renew.sh` script to use your project directory for the 
parameter `DIR`. 
- Register the `ssl_renew.sh` script with `cron`. To do that, run 
```bash
sudo crontab -e
```
Then, add this to the bottom of the file :
```bash
0 12 * * * /path/to/your/repo/ssl_renew.sh >> /var/log/cron.log 2>&1
```
This will run the script `ssl_renew.sh` every 12 hours, and write the log 
to `/var/log/cron.log`. This script runs the `certbot` container with the 
overwrited command `renew`, then restarts the `nginx` container so that it 
reloads its config.

---

And that's it, you're good to go! you should now have an HTTPS-enabled project!

