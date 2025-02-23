# Chapter 26: Managing Containers

**Container**
- a standalone executable software package that includes everything needed to run a piece of software
- packages an application and its dependencies together
- runs on a container engine - an integrated part of the host OS
- containers are run from the container image, which is in the *container registry*
- containers are a way to start an application
- containers execute a command then exit once the command is finished running

**Container registry**: like an app store, but for containers.

3 tools to manage containers:
1. **podman**: tjhe main tool to stop, start and manage containers
2. **buildah**: a specialized tool that helps create custom images
3. **skopeo**: tool used for managing and testing container images

<br>

**namespace**
- provides isolation for system resources
- process (PID), network, user and mount all have namespaces
- you can't access or view anything outside of an individual namespace
  - so, user namespace can't see network namespace for example

**control group/cgoup**: resource access limitation. Allows restriction of memory & number of CPU cycles a process can access

<br>

**Rootless containers**
- offered by podman, where users don't need root privileges or elevated privileges
- they can't access components on the OS where root access is required
- they don't have an IP address and can only bind to a non-priviliged TCP or UDP port
- makes running containers more secure
- files are copied to *~/.local/share/containers/* storage
  - disk space can be used up quickly

<br>

`dnf install -y container-tools` installs all tools for running containers.

`podman run imagename` runs a container.

Containers should be run in *detached* mode (in the background). *Ex:* `podman run -d nginx`.

`podman ps` shows containers that are actively running.

`podman ps -a` showing running and inactive containers.

<br>

**Container images**
- the foundation of every container
- container id a running instance of the image
- created in Docker format
- fetched from *container registries*

`podman info` displays which registries are used.

`podman search` finds available images.
- **--filter** filters the search results
  - *Ex* `podman search --filter is-official=true alpine` gets alpine images created only by official app vendor

UBI can be used to search for images in RH registries.

`skopeo inspect` inspects images from the registry without having to pull them locally.

`podman inspect` inspects images locally. Gives mroe info than skopeo.

* **To run a container, first pull it using `podman pull`, inspect it =, then run it. More secure this way.**

For every container started, an image is downloaded and stored locally. 

`podman rmi` removes container images. Container must be stopped first. 

**Containerfile** has instructions used to build custom images using `podman build`.

`podman stop` stops the container (after 10 seconds).

`podman exec` allows you to run a second command inside a container that has already been started.

Ports 1-1024 are only accesible to the root user. 

`sudo podman run ...` runs a root container.

Some containers need environment variables to run.

<br>

**bind-mount**
- used to add *persistent* storage to podman containers
- a type of mount where a directory is mounted instead of a block device
- for advances storage, OpenShift or Kubernetes is used
- container must be mounted to a directory on the OS
  - must have correct SELinux settings

<br>

`podman unshare ...` runs commands inside the container namespace. Used for rootless containers.

** Systemd is needed to automatically start services if you dont have OpenShift or Kubernetes.

`systemctl --user` allows users to run the common Systemd commands without root permissions, but in the user space only. It works only for services that can run without root permissions.

`podman generate systemd`
- generates a systemd unit file to start containers
- assumes the container already exists
- the file needs to be enabled with a systemctl command
  - *Ex:* `systemctl --user enable container-mycontainer.service`

** For Systemd service containers (rootless podman containers), they only work if you SSH as the user or if you are already logged in as the user. `su` or `sudo` to switch users won't work.

<br>

### Do you already know? Questions

1. Containers use **cgroups**, **namespaces** and **SELinux**. 

2. RH OpenShift provides scalability and availability to containers.

3. To detach from a running container without shutting it down, use **ctrl + p** then **ctrl + q.**.

4. To run a container in the background (detached), use `podman run -d`.

5. To inspect images that have not yet been pulled to your local system, use `skopeo inspect`.

6. `podman info` gives an overview of the registries currently in use.

7. To determine if a container needs environment variables, you can:
- use `podman inspect` to looks for usage info
- use podman run to run the container 

8. The **container_file_t** SELinux content type must be set on the host directory that you want to bind mount to make it available as storage inside the container.

9. `podman run --name mynginx -v /opt/nginx:/var/lob/nginx:Z nginx` performs a bind-mount (adds persistent storage). Sets the correct context type on a host directory which should be exposed as persistent storage inside a container.

10. `loginctl --enable-linger username` allows container that a user has created to start when the system starts as a Systemd service.


### Review Questions

1. `skopeo` is used to work with container images without having to download them from the registry first.

2. Three linux features needed in container environments are **namespaces**, **cgroup** and **SELinux**.

3. The name of the container engine on RHEL9 is CRI-o.

4. */etc/containers/registries.conf* file defines the registries currently being used. 

5. When you start/run a container, the default command is ran and once it finishes executing, the container stops, unless you specify something specific.

6. To start a **rootless container** that bind-mounts a directory in the home directory of the current user account:
- find the UID used by the container
- use `podman unshare` to assign that UID as the owner of the directory you want to provide access to (/home)

7. To find the default command a container uses, use `podman inspect` on the image and look for the "Cmd" field.

8. To start an Ubuntu-based container that prints the contents of */etc/os-release* then exits, start it as an interactive terminal with the **-it** option, then exit after printing the */etc/os-release* file. Or, use `podman run ubuntu cat /etc/os-release`.

9. To run a podman nginx container so that the host port 82 forwards traffic to the container port 80, run these:
- `podman run -d -p 82:80 nginx`
- `firewall-cmd --add-port=82/tcp --permanent`
- `firewall-cmd --reload`

10. To generate a Systemd unit file for the container "nginx", use `podman generate systemd --name nginx --files`. If the container doesn't exist yet, add the **--new** option. The **--files** option creates a .service file in the current directory.
