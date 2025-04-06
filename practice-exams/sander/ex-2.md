# Practice Exam 2

### 2. Configure your system to automatically mount the ISO of the installation disk on the directory /repo. Configure your system to remove this loop-mounted ISO as the only repository that is used for installation. Do not register your system with subscription-manager, and remove all references to external repositories that may already exist.

Same as Ex1

<br>

### 4. Create a 1-GB partition on /dev/sdb. Format it with the vfat file system. Mount it persistently on the directory /mydata, using the label mylabel.


Create the partition with `fdisk /dev/nvmxxx`. In here, specify the size and the type to be **W95 FAT32**.

Make the filesystem be vfat and set the label:
```bash
mkfs.vfat -n mylabel /dev/nvmxxx
```

Create the mentioned mount point:
```bash
mkdir /mydata
```

Mount it in */etc/fstab*:
```bash
/dev/nvmxxx   /mydata   vfat    default   0 0 
```

Mount it with `mount -a` then `reboot` to vverify the changes. 

<br>

### 5. Set default values for new users. Ensure that an empty file with the name NEWFILE is copied to the home directory of each new user that is created.

This requires a change to the default **/etc/skel**.

Add the file to the skeleton:
```bash
touch /etc/skel/NEWFILE
```

Since this skeleton is copied with the creation of a new user, it will ensure NEWFILE is added to the skeleton for each new user's home directory. 

<br>

### 6. Create users laura and linda and make them members of the group livingopensource as a secondary group membership. Also, create users lisa and lori and make them members of the group operations as a secondary group.

Create the groups:
```bash
groupadd livingopensource

groupadd operations
```

Create the users and add them to the specified groups:
```bash
useradd laura -G livingopensource,operations

useradd linda -G livingopensource,operations
```

<br>

### 7. Create shared group directories /groups/livingopensource and /groups/operations and make sure these groups meet the following requirements:
#### 1. Members of the group livingopensource have full access to their directory.
#### 2. Members of the group operations have full access to their directory.
#### 3. Users should be allowed to delete only their own files.
#### 4. Others should have no access to any of the directories.

Create the directories:
```bash
mkdir -p /groups/livingopensource

mkdir -p /groups/operations
```

Change the ownership of the directories to their corresponding groups:
```bash
chown :livingopensource /groups/livingopensource

chown :operations /groups/operations
```

Set the permissions (setGID):
```bash
chmod 2770 /groups/livingopensource

chmod 2770 /groups/operations
```

Set the sticky bit:
```bash
chmod +t /groups/livingopensource

chmod +t /groups/operations
```

<br>

### 8. Create a 2-GiB swap partition and mount it persistently.

Create a partition on the other hard disk with `fdisk`. If there are existing partitions, unmount them with `umount` then proceed.

In `fdisk`, specify the size as +2G, change the type to **swap** then save. 

Make it into a swap:
```bash
mkswap /dev/nvme0n2p2
```

Turn the swap on:
```bash
swapon /dev/nvme0n2p2
```

**Make it persistent by moutning it wuth the UUID in */etc/fstab*:**
Get the UUID with `blkid`.

Make a directory for the mount point.
```bash
mkdir /swapmnt
```

Add this to the */etc/fstab*:
```vim
UUID="76762dd8-xxxxx" /swapmnt	swap	defaults	0 0
```

Verify the changes with `swapon -s`.

<br>

### 9. Resize the LVM logical volume that contains the root file system and add 1 GiB. Perform all tasks necessary to do so.

Since there is no additional space in the main disk to add 1GiB, I'll create it from the other partition and try to point it to this one. 

Check the size of the existing lvm with `lsblk`.

Create a new partition on the additional drive with `fdisk`. 

On the new partition, create a physical volume:
```bash
pvcreate /dev/nvme0n2p3
```

Extend the physical volume to the one for the root fs:
```bash
# Check the name of the existing vg
vgs

vgextend rhel /dev/nvme0n2p3

# Verify the space exists 
vgs
```

Extend the logical volume:
```bash
# Get the logcal volume name to verify the path
lvextend -r -L +1G /dev/rhel/root
```
- **-r** resizes the file system 

Verify the size changed with `lsblk`.

If you don't add the -r option to lvextend, you need to resize the file system based on what it is. `xfs_growfs` for xfs and `resize2fs` for ext4. 

<br>

### 10. Find all files that are owned by user linda and copy them to the file /tmp/lindafiles/.

Create the directory:
```bash
mkdir -p /tmp/lindafiles/
```

Run this script:
```bash
find / -user linda -type f -exec cp --parents {} /tmp/lindafiles/ \;
```

<br>

### 11. Create user vicky with the custom UID 2008.

```bash
useradd vicky -u 2008 
```

<br>

### 12. Install a web server and ensure that it is started automatically.

Install httpd, enable and start it:
```bash
dnf install -y httpd

systemctl enable --now httpd

# Check the status:
systemctl status httpd
```

Add the http service to the firewall permanently:
```bash
firewall-cmd --add-service=http --permanent 

firewall-cmd --reload
```

Test that it's working by adding an index.html to /var/www/html and doing `curl`:
```bash
vim /var/www/html/index.html

curl http://localhost:80
```

<br>

### 13. Configure a container that runs the docker.io/library/mysql:latest image and ensure it meets the following conditions
#### a. It runs as a rootless container in the user linda account.
#### b. It is configured to use the mysql root password password.
#### c. It bind mounts the host directory /home/student/mysql to the container directory /var/lib/mysql.
#### d. It automatically starts through a systemd job, where it is not needed for user linda to log in.


First of all, i have to log in as linda and ensure the container is ran as as systemd user. Enable the linger for this user

the contsiner needs an environment variable 

1. install container-tools as root then switch the user 
2. create the directories
1. pull the image 


Install container-tools, which includes podman:
```bash
dnf install -y container-tools
```

Create the host directory inside of /home/linda and ensure that linda is the owner for all:
```bash
mkdir -p /home/student/mysql

chown -R linda:linda /home/student/mysql
```

As the user linda, pull the specified image:
```bash
podman pull docker.io/library/mysql:latest

# Verify it's there
podman images
```

Run the image, keeping in mind the question requirements:
```bash
podman run -d --name mysql -e MYSQL_ROOT_PASSWORD=password -v /home/student/mysql:/var/lib/mysql:Z docker.io/library/mysql:latest 

# Verify the cotnaienr is up
podman ps
```

Run the container as a Systemd service:

Enable linger for the user:
```bash
loginctl enable-linger linda
```

Create this directory in user linda's home and go into it:
```bash
mkdir -p ~/.config/systemd/user

cd ~/.config/systemd/user
```

Generate the Systemd service files:
```bash
podman generate systemd --name mysql --files
```

Reload the daemon and start the service (as a user for both):
```bash
systemctl --user daemon-relaod

systemctl --user enable --now 

systemctl --user status container-mysql.service
```
