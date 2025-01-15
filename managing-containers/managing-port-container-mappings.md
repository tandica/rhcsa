# Managing container port mappings
## Exercise 26-5


### Step 1: Run a container on a port with proper security settings.

Run an nginx container detached, and expose it on host port 8080.

```bash
podman run --name nginxport -d -p 8080:80 nginx
# Output:

# 9952dfe693df41e218ed22c69519169dadf0779b8b4ac1ac180ae9556880c085
```

Verify the container is available and has port forwarding.

```bash
podman ps
# Output: 

# CONTAINER ID  IMAGE                           COMMAND               CREATED         STATUS         PORTS                         NAMES
# 630e945dcd4d  docker.io/library/nginx:latest  nginx -g daemon o...  38 hours ago    Up 38 hours    80/tcp                        web2
# 9952dfe693df  docker.io/library/nginx:latest  nginx -g daemon o...  42 seconds ago  Up 41 seconds  0.0.0.0:8080->80/tcp, 80/tcp  nginxport
```

Open this port in the firewall on the host operating system.

```bash
firewall-cmd --add-port=8080/tcp --permanent
# Output: 

# success

firewall-cmd --reload
# Output: 

# success
```

Verify that you have access to the nginx welcome page. 

```bash
curl localhost:8080
# Output: 

# s<!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
# html { color-scheme: light dark; }
# body { width: 35em; margin: 0 auto;
# font-family: Tahoma, Verdana, Arial, sans-serif; }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# ...
```


---