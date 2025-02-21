# Offering an NFS share
## Exercise 24-1

This exercise has some steps to set up an NFS server.

### Step 1: Set up the files/directories that will be shared.

Create directories that will be shared.

```bash
su - root 

mkdir -p /nfsdata /users/user1 /users/user2
```

Copy some files into the **/nfsdata** directory.

```bash
cp /etc/[a-c]* /nfsdata
```

Create the **/etc/exports** file and put the necessary data. This defines the NFS share.

```bash
vim /etc/exports
```

Add these lines: 

```
/nfsdata *(rw,no_root_squash)
/users *(rw, no_root_squash)
```


### Step 2: Install and start the NFS server. Add the required firewall config.

Install the *nfs-utils* package

Add VNC server and verify its existence

```bash
dnf install -y nfs-utils
```

Enable the NFS server.

```bash
systemctl enable --now nfs-server
```

Add the *nfs* service to the firewall config permanently.

```bash
firewall-cmd --add-service=nfs --permanent
# Output:

# success
```

Add the *mountd* and *bind* services to the firewall config as well.

```bash
firewall-cmd --add-service=mountd --permanent
# Output:

# success

firewall-cmd --add-service=rpc-bind --permanent
# Output:

# success
```

Reload the new configs.

```bash
firewall --reload
# Output:

# success
```


---