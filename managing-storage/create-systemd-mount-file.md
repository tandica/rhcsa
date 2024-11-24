# Creating a Systemd mount file
## Exercise 14-8


### Step 1: Format a partition to use Ext4

Use the `blkid` command to get the UUID of /dev/nvme0n4p1.

```bash
mkfs.ext4 /dev/nvme0n3p1
# Output:

# mke2fs 1.46.5 (30-Dec-2021)
# Creating filesystem with 262144 4k blocks and 65536 inodes
# Filesystem UUID: f4c101d2-1baf-4a37-aada-c1429a7cba83
# Superblock backups stored on blocks: 
# 	32768, 98304, 163840, 229376

# Allocating group tables: done                            
# Writing inode tables: done                            
# Creating journal (8192 blocks): done
# Writing superblocks and filesystem accounting information: done
```

Verify the change was made. 

```bash
lsblk -f
# Output:

# nvme0n3
# │                                                                             
# ├─nvme0n3p1
# │    ext4   1.0           f4c101d2-1baf-4a37-aada-c1429a7cba83                
# └─nvme0n3p2
#      swap   1             19e6e447-f8fe-47b9-8b74-f18de4c74a2b                [SWAP]
```

> You can also use `blkid` to check this.


### Step 2: Create the mount

Create a directory for a mount point for this partition.

```bash
mkdir /exercise
```

Edit **/etc/systemd/system/exercise.mount**:

```bash
vim /etc/systemd/system/exercise.mount
```

Add this to the file:

```
[Unit]
Before=local-fs.target

[Mount]
What=/dev/nvme0n3p1
Where=/exercise
Type=ext4

[Install]
WantedBy=multi-user.target
```

Save and exit the file.

### Step 3: Enable and verify the mount.

Enable and start the mount: 

```bash
systemctl enable --now exercise.mount
# Output:

# Created symlink /etc/systemd/system/multi-user.target.wants/exercise.mount → /etc/systemd/system/exercise.mount.
```

Verify the mount was created:

```bash
mount | grep exercise
# Output:

# /dev/nvme0n3p1 on /exercise type ext4 (rw,relatime,seclabel)
```

Verify the unit file: 

```bash
systemctl status exercise.mount
# Output:

# ● exercise.mount - /exercise
    #  Loaded: loaded (/etc/systemd/system/exercise.mount; enabled; preset: disabled)
    #  Active: active (mounted) since Sat 2024-11-23 21:48:01 EST; 2min 2s ago
    #   Until: Sat 2024-11-23 21:48:01 EST; 2min 2s ago
    #   Where: /exercise
    #    What: /dev/nvme0n3p1
    #   Tasks: 0 (limit: 22823)
    #  Memory: 40.0K
    #     CPU: 7ms
    #  CGroup: /system.slice/exercise.mount
```


--- 