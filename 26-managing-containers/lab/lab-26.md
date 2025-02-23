# Lab 26

Lab on managing containers.

#### 1. Download the mariadb container image to the local computer. Start the mariadb container, meeting the following requirements: 
#### - The container must be accessible at port 3206. 
#### - The MYSQL_ROOT_PASSWORD must be set to “password” 
#### - A database with the name mydb is created. 
#### - A bind-mounted directory is accessible: the directory /opt/mariadb on the host must be mapped to /var/lib/mysql in the container.

Ensure you are not logged in as a root user. Search for the image container you want and download it.

```bash
podman search maridb

podman pull registry.redhat.io/rhel9/mariadb-1011
# Output:

# Trying to pull registry.redhat.io/rhel9/mariadb-1011:latest...
# Getting image source signatures
# Checking if image destination supports signatures
# Copying blob d990deea8626 skipped: already exists  
# Copying blob ec465ce79861 skipped: already exists  
# Copying blob 040f4a45ea08 skipped: already exists  
# Copying blob 4cdd347d39f2 skipped: already exists  
# Copying blob bd9134490235 skipped: already exists  
# Copying blob facf1e7dd3e0 skipped: already exists  
# Copying config 921ea5a81c done   | 
# Writing manifest to image destination
# Storing signatures
# 921ea5a81cebd25a70805ba210b5c6e02ebf01a3bbb6a18775d3552e07b1f4d7
```

Create a directory for the bind-mounting and set permissions. Make sure the new directory is within the user's namespace (use **~**).

```bash
mkdir -p ~/opt/mariadb

podman unshare chown 27:27 ~/opt/mariadb
```

Run the container with the given settings.

```bash
podman run --name mydblab -d -p 3206:3206 -e MYSQL_USER=linda -e MYSQL_PASSWORD=pass -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=mydb -v /home/linda/opt/mariadb:/var/lib/mysql:Z registry.redhat.io/rhel9/mariadb-1011:latest 
# Output:

# 42d9b0e36e7e438cc7f62c32be415be6c05f39e7df8744cd7b514a3025d50b35
```

Check that db files have been created in the directory.

```bash
ls -Z ~/opt/mariadb
# Output:

# system_u:object_r:container_file_t:s0:c397,c952 data  system_u:object_r:container_file_t:s0:c397,c952 mysql.sock
```


#### 2. Congure systemd to automatically start the container as a user systemd unit upon (re)start of the computer.

Enable *linger* on the current user.

```bash
loginctl enable-linger linda
```

Create a directory to host the Systemd user files.

```bash
mkdir -p ~/.config/systemd/user && cd ~/.config/systemd/user
```

Generate the Systemd user files and verify that it's created.

```bash
podman generate systemd --name mydblab2 --files

ls
# Output:

# container-mydblab2.service
```

Reload Systemd to apply changes.

```bash
systemctl --user daemon-reload
```

Enable the container user service which was just created.

```bash
systemctl --user enable container-mydblab2.service
# Output:

# Created symlink /home/linda/.config/systemd/user/default.target.wants/container-mydblab2.service → /home/linda/.config/systemd/user/container-mydblab2.service.
```

Verify the container is still up and running after a reboot. Ensure you log into the same user. 

```bash
reboot

podman ps 
# Output:

# CONTAINER ID  IMAGE                                         COMMAND               CREATED         STATUS        PORTS                             NAMES
# 3d949b903215  registry.redhat.io/rhel9/mariadb-1011:latest  run-mysqld            17 minutes ago  Up 2 minutes  0.0.0.0:3206->3206/tcp, 3306/tcp  mydblab2
```


---