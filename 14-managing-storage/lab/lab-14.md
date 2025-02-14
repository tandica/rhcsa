
# Lab 14

Lab on managing storage.

#### 1. Add two partitions to your server. Create both partitions with a size of 100 MiB. One of these partitions must be configured as swap space; the other partition must be formatted with an Ext4 file system.

I will create 2 partitions under the disk **/dev/nvme0n4**.

```bash
Command (m for help): n
Partition number (2-128, default 2): 
First sector (2097152-41943006, default 2097152): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2097152-41943006, default 41943006): +100MiB

Created a new partition 2 of type 'Linux filesystem' and of size 100 MiB.

Command (m for help): n
Partition number (3-128, default 3): 
First sector (2301952-41943006, default 2301952): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2301952-41943006, default 41943006): +100MiB

Created a new partition 3 of type 'Linux filesystem' and of size 100 MiB.
```

Change one of the partitions to a swap partition and save the changes.

```bash
Command (m for help): t
Partition number (1-3, default 3): 2
Partition type or alias (type L to list all): swap

Changed type of partition 'Linux filesystem' to 'Linux swap'.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

Make the partition which was not changed to swap have a file system of Ext4. 

```bash
mkfs.ext4 /dev/nvme0n4p3
# Output: 

# mke2fs 1.46.5 (30-Dec-2021)
# Creating filesystem with 102400 1k blocks and 25584 inodes
# Filesystem UUID: 6a37839b-219e-434f-972a-c86d301c38a2
# Superblock backups stored on blocks: 
# 	8193, 24577, 40961, 57345, 73729

# Allocating group tables: done                            
# Writing inode tables: done                            
# Creating journal (4096 blocks): done
# Writing superblocks and filesystem accounting information: done 
```

Continue with formatting the other new partition to be a swap space. The below command sets the partition as a swap space.

```bash
mkswap /dev/nvme0n4p2
# Output:

# Setting up swapspace version 1, size = 100 MiB (104853504 bytes)
# no label, UUID=bd89ce0b-75ca-4873-bdb7-4242b97f2ec0
```

Check the changes made were applied.

```bash
lsblk -f
# Output:

# nvme0n4
# │                                                                              
# ├─nvme0n4p1
# │    ext4   1.0            896a2d6e-1e2d-4f20-be76-b02bcd990982                
# ├─nvme0n4p2
# │    swap   1              bd89ce0b-75ca-4873-bdb7-4242b97f2ec0                
# └─nvme0n4p3
#      ext4   1.0            6a37839b-219e-434f-972a-c86d301c38a2   
```

Next, we have to activate the swap space. Check the memory that is allocated for swap with `free -m`, activate the swap space, then check the memory again to ensure that it is allocated with the changes.

```bash
free -m
# Output: 
#               total        used        free      shared  buff/cache   available
# Mem:            3626        1635        1103          17        1162        1990
# Swap:           9215           0        9215
```

```bash
swapon /dev/nvme0n4p2
```

```bash
free -m
# Output: 
#                total        used        free      shared  buff/cache   available
# Mem:            3626        1637        1101          17        1162        1988
# Swap:           9315           0        9315
```

Verify the swap changes. 

```bash
lsblk -f
# Output:

# nvme0n4
# │                                                                              
# ├─nvme0n4p1
# │    ext4   1.0            896a2d6e-1e2d-4f20-be76-b02bcd990982                
# ├─nvme0n4p2
# │    swap   1              bd89ce0b-75ca-4873-bdb7-4242b97f2ec0                [SWAP]
# └─nvme0n4p3
#      ext4   1.0            6a37839b-219e-434f-972a-c86d301c38a2    
```

We can see that */dev/nvme0n4p2* has been activated as a swap space because of the **[SWAP]** at the end. 


#### 2. Configure your server to automatically mount these partitions. Mount the Ext4 partition on /mounts/data and mount the swap partition as swap space.

Edit the **/etc/fstab** file.

```bash
vim /etc/fstab
```

Add these lines: 

```
UUID=6a37839b-219e-434f-972a-c86d301c38a2 /mounts/data            ext4    defaults        0 0
/dev/nvme0n4p2 none                                               swap    defaults        0 0
```

Verify that there are no errors in the **/etc/fstab** file.

```bash
findmnt --verify
# Output:
# none
#    [W] target specified more than once
#    [W] target specified more than once
# none
#    [W] target specified more than once
# /mounts/data
#    [W] target specified more than once

# 0 parse errors, 0 errors, 4 warnings
```

Mount the newly added file systems.

```bash
mount -a
```


#### 3. Reboot your server and verify that all is mounted correctly

After restarting, use `df -h` to verify the new Ext4 partition. You should see **/dev/nvme0n4p3** in the output.

```bash
df -h
# Output:

# Filesystem      Size  Used Avail Use% Mounted on
# devtmpfs        4.0M     0  4.0M   0% /dev
# tmpfs           1.8G     0  1.8G   0% /dev/shm
# tmpfs           726M  1.9M  724M   1% /run
# /dev/nvme0n1p3   71G   11G   61G  16% /
# /dev/nvme0n1p1 1014M  398M  617M  40% /boot
# /dev/nvme0n4p3   89M   14K   82M   1% /mounts/data
# /dev/nvme0n3p1  974M   24K  907M   1% /exercise
# tmpfs           363M   96K  363M   1% /run/user/1000
# /dev/sr0        9.0G  9.0G     0 100% /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
```

Use `swapon --show` to verify the new partition. You should see **/dev/nvme0n4p2** in the output.

```bash
swapon --show`
# Output:

# NAME           TYPE       SIZE USED PRIO
# /dev/nvme0n1p2 partition    8G   0B   -2
# /dev/nvme0n4p2 partition  100M   0B   -3
# /dev/nvme0n3p2 partition 1024M   0B   -4
```


---