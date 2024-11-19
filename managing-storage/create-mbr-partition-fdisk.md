# Creating MBR partitions with fdisk
## Exercise 14-1

How to add a primary partition.

### Step 1: Add a new disk to the virtual machine

**1.1. Power off the virtual machine.**

**1.2. Go to the vm settings and add a new hard disk. Power on the virtual machine.**

**1.3. Run the `fdisk` command with the newly created disk.**

```bash
fdisk /dev/nvme0n2
# Output:

# Welcome to fdisk (util-linux 2.37.4).
# Changes will remain in memory only, until you decide to write them.
# Be careful before using the write command.

# Device does not contain a recognized partition table.
# Created a new DOS disklabel with disk identifier 0x24b9f762.

# Command (m for help): 
```

### Step 2: Using fdisk

**2.1. type `p` for an overview of the disk allocation**

Output: 
```bash
Command (m for help): p
Disk /dev/nvme0n2: 45 GiB, 48318382080 bytes, 94371840 sectors
Disk model: VMware Virtual NVMe Disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x24b9f762
```

**2.2. type `n` to create a new partition**

Choose the **primary** partition type with `p`. 

Press enter to accept the default partition number given. 

Press enter to accept the default first sector that the partition will start on.

For the last sector specification, type `+2G` for the size of the partition OR you can set the number of the last sector that you want to use OR you can create a partition that sizes a specific number of sectors (+n). 

Output: 
```bash
Command (m for help): p
Disk /dev/nvme0n2: 45 GiB, 48318382080 bytes, 94371840 sectors
Disk model: VMware Virtual NVMe Disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x24b9f762

# This should be the output after specifiying the last sector
Created a new partition 1 of type 'Linux' and of size 2 GiB.
```

**2.3. Write the changes to the disk using `w`**

Output: 
```bash
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0          11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
nvme0n1     259:0    0   80G  0 disk 
├─nvme0n1p1 259:1    0    1G  0 part /boot
├─nvme0n1p2 259:2    0    8G  0 part [SWAP]
└─nvme0n1p3 259:3    0   71G  0 part /
nvme0n2     259:4    0   45G  0 disk 
└─nvme0n2p1 259:5    0    2G  0 part 
```

You can see the newly created partition under the new disk.

---