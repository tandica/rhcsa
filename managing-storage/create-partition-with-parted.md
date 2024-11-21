# Create a partition with *parted*
## Exercise 14-4

Create a partition with **parted** and format the file system. 

### Step 1: Add a new disk to the virtual machine

You need to create a new disk because GPT partitions cannot exist in the same disk as MBR partitions. 

**1.1. Power off the virtual machine.**

**1.2. Go to the vm settings and add a new hard disk. Power on the virtual machine.**

**1.3. Run the `lsblk` command to confirm the newly created disk**

```bash
lsblk
# Output:

NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0          11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
nvme0n1     259:0    0   80G  0 disk 
├─nvme0n1p1 259:1    0    1G  0 part /boot
├─nvme0n1p2 259:2    0    8G  0 part [SWAP]
└─nvme0n1p3 259:3    0   71G  0 part /
nvme0n2     259:4    0   45G  0 disk 
├─nvme0n2p1 259:5    0    2G  0 part 
├─nvme0n2p2 259:6    0    1K  0 part 
└─nvme0n2p5 259:7    0    1G  0 part 
nvme0n3     259:8    0   30G  0 disk 
└─nvme0n3p1 259:9    0    1G  0 part 
nvme0n4     259:10   0   20G  0 disk  
```


### Step 2: Create the partition with *parted*

As the root user, type `parted /dev/<new-diskname>` to enter the interactive **parted** shell.

```bash 
parted /dev/nvme0n4
```

Type `help` to get an overview of the commands.

Type `print` to see an error message of an unrecognized disk label.

Output: 
```bash 
(parted) print                                                            
Error: /dev/nvme0n4: unrecognised disk label
Model: VMware Virtual NVMe Disk (nvme)                                    
Disk /dev/nvme0n4: 21.5GB
Sector size (logical/physical): 512B/512B
Partition Table: unknown
Disk Flags: 
```

Type `mklabel` and hit tab to see the list of available labels.

Type `mkpart` and enter a name for the partition.

For File system type, you can press tab to see all the options, then choose `xfs`.

For start location, you can specify it as a number of blocks or an offset from the start of the device. You can type `1M` or `1MiB` to start the partition at these values. Type `1MiB`.

The end can be set to `1GiB`.


### Step 3: Verify your changes

Still in the *parted* interactive shell, type `print` to see the changes made. 

Output: 
```bash
(parted) print                                                            
Model: VMware Virtual NVMe Disk (nvme)
Disk /dev/nvme0n4: 21.5GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name   Flags
 1      1049kB  1074MB  1073MB  xfs          part1
```

Save your changes with `quit`. 

Type `lsblk` to ensure the changes were applied. 

Output: 
```bash
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0          11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
nvme0n1     259:0    0   80G  0 disk 
├─nvme0n1p1 259:1    0    1G  0 part /boot
├─nvme0n1p2 259:2    0    8G  0 part [SWAP]
└─nvme0n1p3 259:3    0   71G  0 part /
nvme0n2     259:4    0   45G  0 disk 
├─nvme0n2p1 259:5    0    2G  0 part 
├─nvme0n2p2 259:6    0    1K  0 part 
└─nvme0n2p5 259:7    0    1G  0 part 
nvme0n3     259:8    0   30G  0 disk 
└─nvme0n3p1 259:9    0    1G  0 part 
nvme0n4     259:10   0   20G  0 disk 
└─nvme0n4p1 259:12   0 1023M  0 part 
```

### Step 4: Format the partition with a different file system

Format the partition with the **Ext4** file system:

```bash 
mkfs.ext4 /dev/nvme0n4p1
# Output: 

# mke2fs 1.46.5 (30-Dec-2021)
# Creating filesystem with 261888 4k blocks and 65536 inodes
# Filesystem UUID: 896a2d6e-1e2d-4f20-be76-b02bcd990982
# Superblock backups stored on blocks: 
# 	32768, 98304, 163840, 229376

# Allocating group tables: done                            
# Writing inode tables: done                            
# Creating journal (4096 blocks): done
# Writing superblocks and filesystem accounting information: done
```

Now the partition uses the **Ext4** sile system instead of the **XFS** one that was set earlier. 

---