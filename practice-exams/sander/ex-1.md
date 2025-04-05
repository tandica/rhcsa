# Practice Exam 1

### 2. Create user student with password password, and user root with password password.

Root user already has that as a password. As the root user, add student user:

```bash
useradd student

passwd student 
```

<br>

### 3. Configure your system to automatically mount the ISO of the installation disk on the directory /repo. Configure your system to remove this loop-mounted ISO as the only repository that is used for installation. Do not register your system with subscription-manager, and remove all references to external repositories that may already exist.

The question is asking to automatically mount the installation ISO to /repo at boot. This ISO should be the only repo used for package installation. 

Create the directory /repo.

```bash
mkdir /repo
```

The installation of the ISO disk is at */dev/sr0*. Automatically mount it using */etc/fstab* file. First, test it with the `mount` command. Good to test to see if there are any errors.

```bash
# temporarily mounts the /dev/sr0 directory onto /repo
mount /dev/sr0 /repo
```

For RHEL9, there is AppStream and BaseOS, so we need to create 2 repo files for those in */etc/yum.repos.d*:

```bash
vim AppStream.repo
```

In each file, add the title in square brackets, name, baseurl, enabled, and gpgcheck:

```vim
[AppStream]
name=AppStream
baseurl=file:///repo/AppStream
enabled=1
gpgcheck=0
```

```vim
[BaseOS]
name=BaseOS
baseurl=file:///repo/BaseOS
enabled=1
gpgcheck=0
```

The baseurl should point to the local mount point for both AppStream and BaseOS. 

Mount the file in */etc/fstab*:

```bash
vim /etc/fstab
```

Add this: `/dev/sr0		/repo			iso9660	ro		0 0`

`iso9960` is used to specify the file system as an ISO.

`ro` means read only. 

Test with `mount -a`.

Verify that the files in the ISO are now in /repo:

```bash
ls -l /repo
```

You can `reboot` to see if there are any errors, just to be safe, and double check the /repo directory to ensure the mount is persistent.

<br>

### 4. Reboot your server. Assume that you don’t know the root password, and use the appropriate mode to enter a root shell that doesn’t require a password. Set the root password to "mypassword".

- Reboot and press ESC to access the GRUB2 menu. Type `e` to edit.
- Edit the line that defines the intramfs/the line that starts with linux and add `init=/bin/bash`
- Start with ctrl + X
- Once the prompt comes up, remount the root file system to read/write: `mount -o remount,rw /`
- Change the password with `passwd`
- Relabel all files (SELinux): `touch /.autorelabel`
- Start the system with Systemd as PID 1: `exec /usr/lib/systemd/systemd`
- Reboot
- Once the server reboots, login with the new password to test

<br>

### 5. Set default values for new users. Set the default password validity to 90 days, and set the first UID that is used for new users to 2000.

Since this is for new users, it's a system-wide configuration which must be set in **/etc/login.defs**.

As root, edit the file:
```bash
vim /etc/login.defs
```

Change the line **PASS_MAX_DAYS** to 90 and **UID_MIN** to 2000, as the question states.

To verify this, you can create a new user, then type `chage -l username`.

<br>

### 6. Create users edwin and santos and make them members of the group livingopensource as a secondary group membership. Also, create users serene and alex and make them members of the group operations as a secondary group. Ensure that user santos has UID 1234 and cannot start an interactive shell.

Create the groups:
```bash
groupadd livingopensource

groupadd operations
```

Create user edwin:
```bash
useradd edwin -G livingopensource
```

Create user santos:
```bash
useradd santos -G livingopensource -s /sbin/nologin -u 1234
```

Create user serene:
```bash
useradd serene -G operations
```

Create user alex:
```bash
useradd alex -G operations
```

<br>

### 7. Create shared group directories /groups/livingopensource and /groups/operations, and make sure the groups meet the following requirements:

#### 1. Members of the group livingopensource have full access to their directory.
#### 2. Members of the group operations have full access to their directory.
#### 3. New files that are created in the group directory are group owned by the group owner of the parent directory.
#### 4. Others have no access to the group directories.

Create the directories:
```bash
mkdir -p /groups/livingopensource

mkdir -p /groups/operations
```

Change the ownership of the directories to the corresponding group:
```bash
chown :livingopensource /groups/livingopensource

chown :operations /groups/operations
```


Change the permissions of the directory, with the GID specified:
```bash
chmod 2770 /groups/livingopensource

chmod 2770 /groups/operations
```

Verify the directories have an "s" in the permissions with long listing:
```bash
ls -l /groups
```

<br>

### 9. Create a 2-GiB volume group with the name myvg, using 8-MiB physical extents. In this volume group, create a 500-MiB logical volume with the name mydata, and mount it persistently on the directory /mydata.

pv -> vg -> lv 

The current additional disk is 20gb, so I will create a new partition under it with `fdisk`...

Type `n` for new partition, specify the size (+2G), press `t` to change the type to "LVM" and `w` to save the changes.

Create a physical volume on the new partition:
```bash
pvcreate /dev/nvme0n2p1
```

Create a volume group with the desired specifications. Define the extent size here:
```bash
vgcreate -s 8MiB myvg /dev/nvme0n2p1
```

Create the logical volume:
```bash
lvcreate -n mydata -L 500MiB myvg
```

Create a filesystem on the lvm:
```bash
mkfs.ext4 /dev/myvg/mydata
```

Create the directory to mount it on:
```bash
mkdir /mydata
```

Edit the /etc/fstab file: `/dev/myvg/mydata	/mydata			ext4	defaults	0 0`

Verify the mount and check if there are errors:
```bash
mount -a
```

Reboot to ensure persistence.

<br>


### 10. Find all files that are owned by user edwin and copy them to the directory /rootedwinfiles.

Create the directory to copy the files to:
```bash
mkdir /rootedwinfiles
```

Use the `find` command:
```bash
find / -user edwin -exec cp --parents {} /rootedwinfiles \;
```
**--user** specifies which user's files to look for
**-exec** executes a command on the files
**--parents** copies the directory structure so no files are overwitten

<br>


### 11. Schedule a task that runs the command touch /etc/motd every day from Monday through Friday at 2 a.m.

Use `crontab -e` to create a cron job. Run `man 5 crontab` to get the info for date/time fields.

Add this in the crontab editor:
```
0 2 * * 1-5 touch /etc/motd
```

Verify the job has been added:
```bash
crontab -l
```
<br>


### 12. Create user bob and set this user’s shell so that this user can only change the password and cannot do anything else.

Create the user and set the password:
```bash
useradd bob

passwd bob
```

Edit the sudoers file with `visudo` and add the following:
` bob    ALL=(ALL)   NOPASSWD: /usr/bin/passwd`

Restrict the user to only be able to change their password upon login:
```bash
usermod -s /bin/passwd bob
```
<br>


### 13. Install the vsftpd service and ensure that it is started automatically at reboot.

Install, enable and start the service.

```bash
dnf install -y vsftpd

systemctl enable --now vsftpd
```
<br>


### 14. Create a container that runs an HTTP server. Ensure that it mounts the host directory /httproot on the directory /var/www/html.

Ensure you are a non-root user.

Install container-tools:
```bash
dnf install -y container-tools
```

Create the host directory and an index file with some content:
```bash
mkdir /httproot

vim /httproot/index.html
```

Check for podman images for httpd:
```bash
podman images
```

Since there are no existing images, search for the httpd image link, pull it and verify it exists locally:
```bash
podman search httpd

# docker.io/centos/httpd

podman pull docker.io/centos/httpd

podman images
```

Run the image with the necessary parameters:
```bash
podman run -d --name httpdserver -p 8080:80 -v /httproot:/var/www/html docker.io/centos/httpd 
```
-d runs the container in "detached" mode (in the background).

-p specifies the port. Host port 8080 is mapped to container port 80.

-v means volume. It creates a bind-mount, which "mounts" the host directory to the container directory. 

Add the port to the firewall exceptions:
```bash
firewall-cmd --add-port=8080/tcp --permanent

firewall-cmd --reload
```

Add the `http` service to the firewall.
```bash
firewall-cmd --add-service=http
```

Test your changes:
```bash
curl http://localhost:8080
```
<br>


### 15. Configure this container such that it is automatically started on system boot as a system user service.

Make sure you are NOT logged in as a root user. You may need to create the container again as a non-root user...

Enable lingering for the user who created the container. This allows the service to start even though they're not logged in.
```bash
loginctl enable-linger user
```

Create the directory to store the Systemd files in and `cd` into it:
```bash
mkdir ~/.config/systemd/user && cd ~/.config/systemd/user
```

Make sure that the current user is the owner of all the directories. 

Generate the Systemd files with the same name as the container:
```bash
podman generate --name httpdserver --files
```

Reload the daemon then enable and start the service file: 
```bash
systemctl --user reload-daemon

systemctl --user enable --now container-service-file.service
```

<br>

### 16. Create a directory with the name /users and ensure it contains the subdirectories linda and anna. Export this directory by using an NFS server.

Create the directories:
```bash
mkdir -p /users/linda
mkdir -p /users/anna
```

Install the nfs-utils package:
```bash
dnf install -y nfs-utils
```

Enable and start the NFS server service.
```bash
systemctl enable --now nfs-server
```

Add the services **nfs**, **rpc-bind** and **mountd** permanently to the firewall:
```bash
firewall-cmd --add-srevice=nfs --permanent

firewall-cmd --add-srevice=rpc-bind --permanent

firewall-cmd --add-srevice=mountd --permanent

firewall-cmd --reload
```

Create */etc/exports* file if it doesn't exist and edit:
```bash
vim /etc/exports

# add below
/users *(rw,sync,no_root_squash)
```

- **rw** is the read/write permissions
- **sync** allows the changes to be written immediately
- **no_root_squash** keeps the root permissions

Export the directory and verify:
```bash
exportfs -r 

exportfs -v
```

<br>

### 17. Create users linda and anna and set their home directories to /home/users/linda and /home/users/anna. Make sure that while these users access their home directory, autofs is used to mount the NFS shares /users/linda and /users/anna from the same server.

Install autofs: `dnf install -y autofs`

```bash
useradd -m -d /home/users/linda linda

useradd -m -d /home/users/anna anna
```
- **-m** creates a home directory of it doesn't exist
- **-d** specifies the path of the home directory

Configre autofs:

Edit /etc/auto.master and the mount point: 
`/home/users	/etc/auto.users`

Create the secondary file (/etc/auto.users) and edit it:
```bash
linda	-rw	localhost:/users/linda
anna	-rw	localhost:/users/anna
```

Add the directories that need to be shared, in this case, /linda and /anna, the read/write permissions and the server it needs to be mounted to.

Start and enable autofs. 
```bash
systemctl enable --now autofs
```