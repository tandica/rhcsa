# containers 

## beanoligi

#### find and retrieve container img / inspect container images / container mgmt

install container tools package and skopeo 

skopeo is used to inspect container images 

find an image in a registry: `podman search`

`podman login registry-url` logs into registry

Sometimes you hae to login to skopeo. 

`podman images` lists all images

`podman inspect` inspects images that are already installed locally 

#### perform container mgmt 

`podman ps -a` lists all running and not running containers 

`podman rm containername/id` removes container

`podman run -it --name containername` runs interactive shell inside a container. you can install packages within the container or run any other commands. 

To start back a container that was stopped: `podman start containername`. 

To go back inside an interactive container: `podman exec -it containername /bin/bash`. /bin/ bash can be the value of the cmd field when inspecting. 

`podman run -d --name containername containerid` -d option runs the container in **detached** mode which means it runs in the background. 

`podman kill containername` stops the container. 

#### Run a service inside a container & attach persistent storage 

In `podman run --name containername -d -p 4080:8080 containerid`, -p is for port. We are binding a port from host system to one from the guest. In the inspect for the image, this container was set to listen to port 8080, but we want it to listen to 4080. This won't work if you use privileged ports. 

Make a permanent firewall exception for the specified port: `firewall-cmd --permanent --add-port=4080/tcp`. then reload the firewall. 

#### attach persistent storage 

same way u can forward a port , you can forward storage. 

`podman run --name mycomt -d -p 4080:8080 -c /home/dir:/var/container:z`

**-v** option is for volume. 

you can write log messages in the exec output with logger. 

#### building containerfiles and have containers start as a systems service 

create file called Containerfile. 

`loginctl enable-linger username` enables linger so container can be persistent 

`loginctl show-user username` shows details for the specified user, including linger value. 


<br>

## DexTutor

You need to login to the podman registry in the exam.

`podman pull img` pulls docker image.

If asked to map a volume, it means you have to map a directory on your system to a directory on the container. Usually, you have to create the local directory.

`podman run -d --name Web1 -p 8080:80 -v /local/dir:/container/dir:Z xxximg-idxxx` runs a container mapped to a specific port, also mapped to a local directory.


#### Run container as a service

1. Create a directory with -p option

`mkdir -p ~/.config/systemd/user`

2. Go into that directory

`cd ~/.config/systemd/user`

3. Generate systemd file

`podman generate systemd --name web2 --files --new`

This generates a web2.service file. Check this with `ls` in the current directory you're in.

Double check in this file that it has **WantedBy=default.target** with vim.

4. Reload the user, start & enable the service.

`systemcl --user daemon-reload`

`systemctl --user start container-web2.service`

`systemctl --user enable container-web2.service`

Check the status of the service.

`systemctl --user status container-web2.service`

<br>

With this, you can host any web page through the container by creating some index.html file, putting content in it and calling it with curl to check that its working.


