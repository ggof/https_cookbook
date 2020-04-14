### INITIAL SETUP
To use this with docker swarm, please read the instructions first.
The configurations needed are not what you could call "straightforward",
and you might need some tinkering. Here are the steps to start this 
repository from scratch : 

- Clone this repo and `cd in_docker`.
- Open the nginx conf from `nginx/nginx.conf`. This config has been 
intentionaly left generic. Modify it as you need (at least modify **ALL** 
the fields enclosed with `<>`).
- Modify the current docker-compose (`stack.yml`) file so that it suits your project. 
You can modify the `nginx` part, but It will be much easier if you don't.
- Run the script `init.sh`, which will ask you for sudo rights. This will create your 
Diffie-Hellman keys for encryption and will also init a swarm and deploy the stack to it.
**TAKE NOTE**: The name of the stack is the string written in the file `stack_name.txt`. 
If you want another stack name, change it in this file.
- Modify `ssl_staging.sh` by adding your own domain and the 
directory your app lives in and run it to validate your configuration is correct.
- If everything went well, you can now modify and run the file `ssl_prod.sh` the same way. 
This will create your "real" certificates, and put them in the `certs` directory.
- Once this is done, you should have HTTPS certificates. You now need to enable 
the HTTPS config in `nginx/nginx.conf`.
- Open `nginx/nginx.conf` and uncomment the `server` block that handles port 443. 
Also replace everything that is enclosed with `<>` with your own data. Save and exit.
- Reload your nginx container with : 
```bash
docker service update --force --stop-signal SIGHUP $(cat stack_name.txt)_nginx
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

Note that running in swarm mode has several advantages versus the good old 
docker-compose setup. First, updating containers to a newer version is easier. 
Second, the use of a swarm allows for some monitoring. Third, it uses the exact 
same file format as docker-compose, so modifying your already existing file to fit 
a swarm shouldn't be very tedious. 
