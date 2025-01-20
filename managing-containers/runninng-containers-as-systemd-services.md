# Running containers as Systemd services
## Exercise 26-9


### Step 1: Create a new user and enable the *linger* feature for this user.

Create a new user and set a password for it.

```bash
sudo useradd linda

sudo passwd linda
```

Enable *linger* feature.

```bash
sudo loginctl enable-linger linda
```

### Step 2: Configure Systemd services to run containers with this user.

Create a directory where systemd user files will be created.

```bash
mkdir -p ~/.config/systemd/user && cd ~/.config/systemd/user
```

Start an *nginx* container pointing host port 8081 to port 80 and verify its been started.

> When you access port 8081 on your machine, it will be redirected to port 80. Port 80 is inside the container where the nginx service is listening.

```bash
podman run -d --name mynginx -p 8081:80 nginx

podman ps
# Output:

# CONTAINER ID  IMAGE                           COMMAND               CREATED        STATUS        PORTS                         NAMES
# e0f74c4beee5  docker.io/library/nginx:latest  nginx -g daemon o...  2 minutes ago  Up 2 minutes  0.0.0.0:8081->80/tcp, 80/tcp  mynginx
```

Generate the Systemd user files and check that its created.

```bash
podman generate systemd --name mynginx --files

ls
# Output:

# container-mynginx.service
```

Ensure Systemd picks up these changes.

```bash
systemctl --user daemon-reload
```

Enable the Systemd user service which was created above. No need to start as it's already running.

```bash
systemctl --user enable container-mynginx.service
# Output:

# Created symlink /home/linda/.config/systemd/user/default.target.wants/container-mynginx.service → /home/linda/.config/systemd/user/container-mynginx.service.
```

Reboot the server and open a shell as a non-root user. Check that the **mynginx** container is started and running as user linda.

```bash
reboot

ps faux | grep -A3 -B3 mynginx
# Output:

# linda       1719  0.0  0.2  29880  9668 ?        S    08:37   0:00  \_ (sd-pam)
# linda       2272  0.0  0.0   1084   512 ?        S    08:37   0:00  \_ catatonit -P
# linda       2405  0.0  0.4  72076 18424 ?        Ss   08:37   0:00  \_ /usr/bin/pasta --config-net -t 8081-8081:80-80 --dns-forward 169.254.0.1 -u none -T none -U none --no-map-gw --quiet --netns /run/user/1002/netns/netns-343885d7-0428-5587-3416-8dd1d5e94d57
# linda       2420  0.0  0.0 226604  2320 ?        Ss   08:37   0:00  \_ /usr/bin/conmon --api-version 1 -c e0f74c4bee
# ...
```


---