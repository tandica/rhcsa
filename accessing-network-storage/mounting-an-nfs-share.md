# Mounbting an NFS share
## Exercise 24-2


### Step 1: Mount an NFS share from server1 to server2.

Log in to server1.

```bash
ssh student@server1
```

Install the required package that has *showmount* and get the available exports from server2.

```bash
dnf install -y nfs-utils

showmount -e server2.example.com
```


### Step 2: Perform a NFS pseudo root mount of all NFS shares.

Mount all NFS shares in server2.

```bash
mount server2.example.com:/ /mnt
```

Verify the mount has succeeded.

```bash
mount | grep server2
```

Show the directories and subdirectories and see that they correspond to the mounts offered by the NFS server. 

```bash
ls /mnt
```


---