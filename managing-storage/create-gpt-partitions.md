# Create a GPT partition
## Exercise 14-3

How to create a GPT partition.

### Step 1: Add a new disk to the virtual machine

You need to create a new disk because GPT partitions cannot exist in the same disk as MBR partitions. 

**1.1. Power off the virtual machine.**

**1.2. Go to the vm settings and add a new hard disk. Power on the virtual machine.**

**1.3. Run the `lsblk` command to confirm the newly created disk**

```bash
lsblk
# Output:

# NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
# sr0          11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
# nvme0n1     259:0    0   80G  0 disk 
# ├─nvme0n1p1 259:1    0    1G  0 part /boot
# ├─nvme0n1p2 259:2    0    8G  0 part [SWAP]
# └─nvme0n1p3 259:3    0   71G  0 part /
# nvme0n2     259:4    0   45G  0 disk 
# ├─nvme0n2p1 259:5    0    2G  0 part 
# ├─nvme0n2p2 259:6    0    1K  0 part 
# └─nvme0n2p5 259:7    0    1G  0 part 
# nvme0n3     259:8    0   30G  0 disk 
```

### Step 2: Create the GPT partition

**2.1. Run the `gdisk` command with the newly created disk.**

```bash
gdisk /dev/nvme0n3
```

**2.2. Press `n` for a new partition and choose the default partition number.**

**2.3. Press enter to accept the default first sector.**

**2.4. For the last sector, type **+1G**. If you choose default, it will take up the entire space of the disk.**

**2.5. For setting the partition type, type `l` to show the the list of options. Press enter to accept the default option, which is 8300 (Linux file system).**

**2.6. The partition is created, but not yet saved. Type `p` to see an overview of of it and verify if you want to save it.**

```bash 
Command (? for help): p
Disk /dev/nvme0n3: 62914560 sectors, 30.0 GiB
Model: VMware Virtual NVMe Disk
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): 3E10E3B4-02B4-44A5-BEA5-8B305519FE2B
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 62914526
Partitions will be aligned on 2048-sector boundaries
Total free space is 60817341 sectors (29.0 GiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         2099199   1024.0 MiB  8300  Linux filesystem
```

**2.7. Type `w` to save the changes.**

```bash 
Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): y
OK; writing new GUID partition table (GPT) to /dev/nvme0n3.
The operation has completed successfully.
```

---