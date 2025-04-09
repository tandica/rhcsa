# Questions from AI

## 1. NFS / autofs
You are a system administrator managing two servers:

- server1.example.com (192.168.1.10) - NFS server
- server2.example.com (192.168.1.20) - Client system

Your tasks are divided into two parts:

### Part 1: Configure the NFS Server (server1)
On server1.example.com, perform the following tasks:

Install and enable the necessary NFS server packages

**a.** Create a directory structure /exports/projects with subdirectories:
- /exports/projects/development
- /exports/projects/testing
- /exports/projects/production

**b.** Create a local group projectusers with GID 5000

**c.** Create three local users:
- devuser (UID 5001) - member of projectusers group, with primary access to development
- testuser (UID 5002) - member of projectusers group, with primary access to testing
- produser (UID 5003) - member of projectusers group, with primary access to production

**d.** Set appropriate permissions:
- Make devuser the owner of the development directory
- Make testuser the owner of the testing directory
- Make produser the owner of the production directory

**e.** Ensure all directories are writable by their respective owners and readable by all members of projectusers

**f.** Configure NFS to export all project directories with read-write access to server2.example.com

**g.** Ensure the NFS service starts at boot and is currently running

**h.** Apply appropriate SELinux contexts to allow NFS sharing

---

<br>

```bash
dnf install -y nfs-utils autofs

systemctl enable --now nfs-utils
```

Create directories:
```bash
mkdir -p /exports/projects/development
mkdir -p /exports/projects/testing
mkdir -p /exports/projects/producton
```

Create group and users:
```bash
groupadd projectusers -g 5000

useradd devuser -u 5001 -G projectusers 
useradd testuser -u 5002 -G projectusers 
useradd produser -u 5003 -G projectusers 
```

Change the owners of the directories:
```bash
chown -R devuser:projectusers /exports/projects/development/
chown -R testuser:projectusers /exports/projects/testing/
chown -R produser:projectusers /exports/projects/producton/
```

Make sure users can write to their directories and groups can read:
```bash
chmod -R 750 /exports/projects/development/
chmod -R 750 /exports/projects/testing/
chmod -R 750 /exports/projects/producton/
```

Edit the */etc/exports* file and add `/exports/projects *(rw,no_root_squash)`.

Add the SELinux context label and apply it to the directory:
```bash
semanage fcontext -a -t nfs_t "/exports(*/.)"

# Apply the changes with restorecon
restorecon -vR /exports
```

Export the NFS and verify it: 
```bash
exportfs -r

# Verify
exportfs -v
showmount -e
```

---

### Part 2: Configure AutoFS on the Client (server2)
On server2.example.com, perform the following tasks:

Install and enable the necessary AutoFS and NFS client packages

**a.** Create the same local users and group as on server1

**b.** Configure AutoFS to automatically mount the exported directories from server1:
- The mount point should be /projects
- Each subdirectory (development, testing, production) should be automounted on demand
  - For example, accessing /projects/development should automatically mount server1.example.com:/exports/projects/development
- Ensure that the AutoFS service starts at boot

**c.** Verify that users can properly access their respective directories:
- devuser should be able to write to the development directory
- testuser should be able to write to the testing directory
- produser should be able to write to the production directory
- All users should be able to read all directories but only write to their own

--- 

<br>

```bash
dnf install -y nfs-utils autofs

systemctl enable --now nfs-utils
```

Create the same users and group with the same GID and UIDs:
```bash
groupadd projectusers -g 5000
useradd devuser -u 5001 -G projectusers 
useradd testuser -u 5002 -G projectusers 
useradd produser -u 5003 -G projectusers 
```

Create the mount point:
```bash
mkdir /projects
```

**To configure autofs:**

Edit */etc/auto.master*
```bash
/exports/project  /etc/auto.projects
```

Create the secondary file (/etc/auto.projects) and map each directory:
```bash
development	-rw	server1:/exports/projects/development
testing		-rw	server1:/exports/projects/testing
production	-rw	server1:/exports/projects/production
```

Enable autofs:
```bash
systemctl enable --now autofs
```

Test it by switching to the created users and checking permissions with each directory for read/write.

---

<br>

## 2. Change the port for httpd service to listem to port 82.

Edit the httpd config file */etc/httpd/conf/httpd.conf*
- Go to the "Listen" line and change the port number to 82. 

Restart and notice the error. 

Check the semanage port information for http:
```bash
semanage port -l | grep http
```

Port 82 is not listed under http_port_t, so we have to add it:
```bash
semanage port -a -t http_port_t -p tcp 82
```

Restart the httpd service and check the status. 

<br>

## 3. Add user who's login shell should be non-interactive

```bash
useradd tommi -s /sbin/nologin
```

<br>

## 4. Create the admin group and /admins directory where only group users can read and write and others cannot access. Ensure that the files created by the users are automatically owned by the admin group.

Create the group.

Add the appropriate owners and permissions:
```bash
chown :admin /home/admins

# Make new files autom,atically be owned by the admin group
chmod 2770 /home/admin
```

<br>

## 5. Configure a task that runs `echo hello` command at 15:27 every day.

Use `crontab -e`.

<br>

## 6. Find the files owned by tandi, and copy it to catalog: /opt/dir

```bash
mkdir -p /opt/dir
```

```bash
find / -user tandi -type f -exec cp --parents {} /opt/dir \;
```

<br>

## 7. Find all files in /usr that is less than 50k but greater than 30k in size.

Create a script file:
```bash
vim filesize.sh
```

Add the script:
```bash
#!/bin/bash

find /usr -type f -size +30k -size -50k -exec ls -lh {} /;
```

Ensure script is executable:
```bash
chmod 755 filesize.sh
```

<br>

## 8. Create a 1G swap partition which starts automatically on boot.


Create the partition with `fdisk`.

Make the partition a swap `mkswap /dev/nvmxxx`.

Turn the swap on `swap on /dev/nvmxxx`.

To make it persistent, add it in the /etc/fstab file and refer to it by UUID:

`UUID="88595e4f-e4a4-41a1-84ce-fed4face4155"	none	swap	defaults	0 0`

<br>

## 9. Configure a HTTP server, which can be accessed through http://localhost.example.com.

Install and enable httpd service.

Add http service to the firewall:
```bash
firewall-cmd --add-service=http --permanent

firewall-cmd --reload
```

In */etc/hosts*, add your ip and the specified hostname. 
```bash
192.168.32.132 http://localhost.example.com
```

Test it:
```bash
curl http://localhost.example.com
```

<br>

## 10. Install a FTP server and configure anonymous download from /var/ftp/pub catalog.

Install and enable the ftp service.

```bash
dnf install -y vsftpd

systemctl enable --now vsftpd
```

Add the vsftpd service to the firewall:
```bash
firewall-cmd --add-service=ftp --permanent

firewall-cmd --reload
```

Edit the vsftpd config */etc/vsftpd/vsftd.conf* file. In `anonymous_enable` line, type YES. 
```bash
anonymous_enable=YES
```

Restart the servcie:
```bash
systemctl restart vsftpd
```

Create a test file in */var/ftp/pub*.

Test it:
```bash
ftp localhost
# Trying ::1...
# Connected to localhost (::1).
# 220 (vsFTPd 3.0.5)
# Name (localhost:root): anonymous
# 331 Please specify the password.
# Password:
# 230 Login successful.
# Remote system type is UNIX.
# Using binary mode to transfer files.
ftp> cd pub
250 Directory successfully changed.
ftp> get test.txt
local: test.txt remote: test.txt
# 229 Entering Extended Passive Mode (|||30772|)
# 150 Opening BINARY mode data connection for test.txt (0 bytes).
# 226 Transfer complete.
```

<br>

## 11. Find the rows that contain xyz from file /etc/testing, and write it to the file/tmp/testing.

Create the file for the output: `touch /tmp/testing`

Use `grep` to find the characters and output them to the file:
```bash
grep "xyz" /etc/testing > /tmp/testing
```

Verify the output is there:
```bash
cat /tmp/testing
```

<br>

## 12. NFS Wilcard 

### Server 2:
- Create a group called 'engineers' with GID 6000
- Create three users: 'alex', 'sam', and 'taylor' with UIDs 6001, 6002, and 6003 respectively
- Add all three users to the 'engineers' group
- Create a directory structure at /exports/home where each user will have their home directory
- Set appropriate ownership and permissions on these directories
- Configure the NFS server to export /exports/home with read/write access to server1
- Ensure the NFS service starts automatically after reboot

### Server 1:
- Create the same group 'engineers' with GID 5000
- Create the same three users with matching UIDs
- Configure autofs to automatically mount the users' home directories from the NFS server
- Use a wildcard configuration that will map any access to /rhome/* to the appropriate user directory on the NFS server
- Set the timeout for these mounts to 300 seconds (5 minutes)
- Ensure the autofs service starts automatically after reboot

Success criteria:
When users log in on the client system, their home directory should be automatically mounted from the NFS server
For example, when user 'alex' accesses /rhome/alex, the directory should be automatically mounted from nfs-server:/exports/home/alex
The mounts should persist until 5 minutes of inactivity, then automatically unmount
File creation and permissions should work correctly across both systems
Changes made on either system should be immediately visible on the other

--- 

<br>

**Server2:**

Ensure nfs-utils and autofs are installed and nfs, rpc-bind and mountd are added tot he firewall. 

```bash
groupadd engineers -g 6000
useradd alex -G engineers -u 6001
useradd sam -G engineers -u 6002
useradd taylor -G engineers -u 6003
```

Create directory structure and apply appropriate permissions:
```bash
mkdir -p /exports/home/alex
mkdir -p /exports/home/sam
mkdir -p /exports/home/taylor

chown -R alex:alex /exports/home/alex/
chown -R sam:sam /exports/home/sam/
chown -R taylor:taylor /exports/home/taylor/

chmod 770 -R /exports/home/taylor/
chmod 770 -R /exports/home/sam/
chmod 770 -R /exports/home/alex/
```

Edit *etc/exports* file. Add:
`/exports/home	*(rw,no_root_squash)`

Export it: `exportfs -r` and verify: `showmount -e`.

Server1:

Create the same group and users with the same GID and UIDs:
```bash
groupadd engineers -g 6000
useradd alex -G engineers -u 6001
useradd sam -G engineers -u 6002
useradd taylor -G engineers -u 6003
```

Ensure nfs-utils and autofs are installed and nfs, rpc-bind and mountd are added tot he firewall. 

Create the mount point directory: `mkdir /rhome`. 

Edit the /etc/auto.master file and add:
```bash
/rhome/   /etc/auto.rhome   --timeout=300
```

Create and add to the secondary file:
```bash
*   -rw   server2:/exports/home/&
```

Here, make sure the wildcard elements are added 
- * for the reference directory 
- **&** to apply to all directories

Restart the autofs service and test the changes. 

<br>

## 13. LVM Creation and Resizing (Add)

### Use a 1-GiB disk/partition (/dev/sdX1) to create a volume group named vgtest with 4-MiB physical extents. 

### In vgtest, create a 120-extent logical volume named lvtest. Format it with XFS and mount it persistently on /groups.

### Add 60 extents to lvtest and ensure the XFS filesystem resizes accordingly.

Create a partition in the hard disk with `fdisk`. Set the size to 1GiB.

Make this partition a physical volume:
```bash
pvcreate /dev/xxx
```

Create a volume group in the physical volume and set the size and name:
```bash
vgcreate -s 4MiB vgtest /dev/xxx
```

Create the LVM with the desired size and set the filesystem:
```bash
lvcreate -l 120 -n lvtest vgtest

mkfs.xfs /dev/vgtest/lvtest
```

Create the mount point and add to the */etc/fstab* file:
```bash
mkdir /mnttest

# Add to /etc/fstab:
/dev/vgtest/lvtest   /mnttest    defaults    0 0

# Mount the files
mount -a
```

Increase the LVM size and the filesystem (with **-r**): 
```bash
lvextend -l +60 -r /dev/vgtest/lvtest
```

Verify the changes were applied:
```bash
lvs 

df -h
```

<br>

## 14. Resize existing LVM (Add)

### Add 300mb of space to lvprac lvm.

```bash
lvextend -l +300M -r /dev/vgprac/prac
```

<br>

## 13. LVM Creation and Resizing (Add)

Create a 1G partition in the existing disk. 

Unmount existing partitions and swapoff any swaps. 

If fdisk is still giving an error, use `vgchange -an vgname` to temporarily disable the volumegroup. Reactivate it with `vgchange -ay vgname` after the new partition is created.

Create pv, vg and lv:
```bash
pvcreate /dev/nvme0n3p3

vgcreate -s 4MiB vgr

lvcreate -L 300M -n lvr vgr
```

Make it into ext4 file system - use the file path with the volume group and lv name:
```bash
mkfs.ext4 /dev/vgr/lvr
```

Increase the size by 200mb:
```bash
lvextend -L +200M -r /dev/vgr/lvr
```

Make you the **+** sign is there to specify increase!!!

<br>

## 14. Resize existing LVM (Reduce)

Reduce the above lvm by 150MB. 
```bash
lvreduce -L -150M -r /dev/vgr/lvr
```

<br>

## 15. Enable root login via ssh

Edit the */etc/ssh/sshd_config* file. Set PermitRootLogin to yes:
```bash
PermitRootLogin yes
```

<br>

## 16. Create a script that prints a message on login as a certain user. 

Create the script in */usr/local/bin*

```bash
vim /usr/local/bin/welcome.sh

# Add the below
echo "Welcome tom!"

# Give the script the right permissions:
chmod 755 /usr/local/bin/welcome.sh
```

Add the path to the script in the user's bash_profile file, after the if loop (*/home/tom/bash_profile*).

<br>

## 17. Configure recommended tuned profile

Install, enable and start `tuned`.

Get the recommended tuned profile:
```bash
tuned-admn recommend
```

Set the recommended profile and verify:
```bash
tuned-admn profile virtual-guest

tuned-adm active
```

<br>

## 18. Time Synchronization with another server

Install, enable and start chrony service.

Edit the /etc/chrony.cond file
- comment out the pool line
- put the server name and keep the iburst at the end
```bash
server server1 iburst
```

Add ntp to the firewall:
```bash
firewall-cmd --add-service=ntp
```

Restart chronyd serveice. 

Verify the synchronization (look for *):
```bash
chronyc sources
```

<br>

## 19. Create a container that runs an HTTP server. Ensure that it mounts the host directory /httproot on the directory /var/www/html. Configure this container such that it is automatically started on system boot as a system user service.

Install container-tools. 

Run this container as user tom...make sure you `ssh` as that user, not `su`.

Create the host directory mentioned:
```bash
mkdir /httproot
```

**Make sure the directory is owned by the same user you're logged in with:**
```bash
chown tom:tom /httproot
```

Pull the mentioned image:
```bash
podman pull docker.io/xxx
```

Run the container (**don't forget the port for http service and the :Z for selinux!!!**):
```bash
podman run -d --name httpserver -p 8080:80 -v /httproot:/var/www/html:Z docker.io/xxx
```

Verify it was created `podman ps -a`. 

Add http and the ports to the firewall:
```bash
firewall-cmd --add-service=http --permanent
firewall-cmd --add-port=80 --permanent
firewall-cmd --add-port=8080 --permanent

firewall-cmd --reload
```

For running as a systemd user service on boot:

Enable linger for the user:
```bash
systemctl enable-linger tom
```

Create the directory and `cd` into it: `mkdir ~/.config/systemd/user` 

Generate the systemd unit files:
```bash
systemctl generate systemd --name httpserver --files
```

Reload the daemona and enable/start the service:
```bash
systemctl --user daemon-reload

systemctl --user enable --now container-httpserver.service
```

Check the status of the service and you can reboot and check the container started at the same time as the boot with `podman ps -a`.

<br>

## Make ssh service listen on another port 