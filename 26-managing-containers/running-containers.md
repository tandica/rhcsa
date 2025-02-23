# Running containers with podman
## Exercise 26-1


### Step 1: Run a container.

Install the necessary container software.

```bash
su - root

dnf -y install container-tools
```

List the existing containers.

```bash
podman ps -a
# Output: 

# CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
```

No containers exist so nothing is listed.

Run an *nginx* container in detached mode.

```bash
podman run -d nginx
# Output: 

# ✔ docker.io/library/nginx:latest
# Trying to pull docker.io/library/nginx:latest...
# Getting image source signatures
# Copying blob 566e42bcee1c done   | 
# Copying blob da8cc133ff82 done   | 
# Copying blob 1e109dd2a0d7 done   | 
# Copying blob 2b99b9c5d9e5 done   | 
# Copying blob fd674058ff8f done   | 
# Copying blob bd98674871f5 done   | 
# Copying blob c44f27309ea1 done   | 
# Copying config f876bfc1cc done   | 
# Writing manifest to image destination
# 31e278acf10f029975ea4c8fb3f0dc9e5b82d0e54bf44709008d33f1a2794799
```

If there is an authentication error, you need to log in with your RedHat account credentials, especially if you chose an nginx container from the RedHat registry. Otherwise, choose the container from the Docker hub so you don't need to autheticate. 

```bash
podman login registry.redhat.io
# Input credentials when prompted
```

Observe the output of containers after this installation.

```bash
podman ps
# Output:

# CONTAINER ID  IMAGE                           COMMAND               CREATED             STATUS             PORTS       NAMES
# 31e278acf10f  docker.io/library/nginx:latest  nginx -g daemon o...  About a minute ago  Up About a minute  80/tcp      quizzical_proskuriakova
# bf64ff8c9158  docker.io/library/nginx:latest  nginx -g daemon o...  42 seconds ago      Up 42 seconds      80/tcp      nifty_ritchie
```

### Step 2: Run an interactive container. 

Install the *busybox* cloud image as an interactive shell container.

```bash
podman run -it busybox
# Output:

# Resolved "busybox" as an alias (/etc/containers/registries.conf.d/000-shortnames.conf)
# Trying to pull docker.io/library/busybox:latest...
# Getting image source signatures
# Copying blob 9c0abc9c5bd3 done   | 
# Copying config af47096251 done   | 
# Writing manifest to image destination
# / # 
```

This gives access to the shell that's running which you can run commands inside.

> The options `-it`: `i` means interactive and `t` means tty. It mimicks a regular terminal session within a container.

Run the `ps aux` command inside the shell.

```
/ # ps aux
PID   USER     TIME  COMMAND
    1 root      0:00 sh
    2 root      0:00 ps aux
```

Exit the shell. 

```
/ # exit
```

Check all the containers to see if *busybox* is there.

```bash 
podman ps
# Output:

# CONTAINER ID  IMAGE                           COMMAND               CREATED         STATUS         PORTS       NAMES
# 31e278acf10f  docker.io/library/nginx:latest  nginx -g daemon o...  54 minutes ago  Up 54 minutes  80/tcp      quizzical_proskuriakova
# bf64ff8c9158  docker.io/library/nginx:latest  nginx -g daemon o...  54 minutes ago  Up 54 minutes  80/tcp      nifty_ritchie
```

It's not in the output because it was exited in the previous step. 

Run the busybox container again and make it run in the backgroud (in detached mode) by pressing **ctrl + p**, **ctrl + q** once you have access to the interactive shell.

```bash
podman run -it busybox
```

List all containers again.

```bash 
podman ps
# Output:

# CONTAINER ID  IMAGE                             COMMAND               CREATED             STATUS             PORTS       NAMES
# 31e278acf10f  docker.io/library/nginx:latest    nginx -g daemon o...  About an hour ago   Up About an hour   80/tcp      quizzical_proskuriakova
# bf64ff8c9158  docker.io/library/nginx:latest    nginx -g daemon o...  About an hour ago   Up About an hour   80/tcp      nifty_ritchie
# 6acf3d5ae946  docker.io/library/busybox:latest  sh                    About a minute ago  Up About a minute              focused_einstein
```

Notice that the *busybox* container is now running in the background.

Reconnect to the interactive shell in the *busybox* container.

```bash
podman attach focused_einstein
# Output:

#  / #
```

Detach from it again with **ctrl + p**, **ctrl + q**.

Stop the container.

```bash
podman stop focused_einstein
# Output:

# WARN[0010] StopSignal SIGTERM failed to stop container focused_einstein in 10 seconds, resorting to SIGKILL 
# focused_einstein
```

Check that the container was stopped.

```bash 
podman ps
# Output:

# CONTAINER ID  IMAGE                           COMMAND               CREATED      STATUS      PORTS       NAMES
# 31e278acf10f  docker.io/library/nginx:latest  nginx -g daemon o...  2 hours ago  Up 2 hours  80/tcp      quizzical_proskuriakova
# bf64ff8c9158  docker.io/library/nginx:latest  nginx -g daemon o...  2 hours ago  Up 2 hours  80/tcp      nifty_ritchie
```


---