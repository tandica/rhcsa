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