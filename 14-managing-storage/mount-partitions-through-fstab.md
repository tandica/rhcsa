# Mounting partitions through /etc/fstab
## Exercise 14-7


### Step 1: Mount a partition in the /etc/fstab file

Use the `blkid` command to get the UUID of /dev/nvme0n4p1.

```bash
blkid
```

Create a directory for a mount point for this partition.

```bash
mkdir -p /mounts/data
```

Edit the **/etc/fstab** file with the following line:

`UUID=a4a79303-4341-4f11-8daa-09457a6f72a5 /mounts/data            xfs     defaults        0 0`

```bash
vim /etc/fstab
```

After the change is added, verify the **/etc/fstab** file does not have any errors. 

```bash
findmnt --verify 
# Output:

# none
#    [W] target specified more than once

# 0 parse errors, 0 errors, 1 warning
```

### Step 2: Test and verify the changes 

Since the **/etc/fstab** was modified, you should reload it then mount everything on that file. 

```bash
systemctl daemon-reload

mount -a
```

Verify that the partition was mounted correctly. 

```bash
df -h

# Output: 

# /dev/nvme0n2     45G  354M   45G   1% /mounts/data
```

> `df -h` shows disk space usage and where the file system is mounted on. 


--- 