# Creating a physical volume
## Exercise 15-1


### Step 1: Create a new disk 

Create a fresh disk to put the LVM partition on.

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
nvme0n2     259:4    0   45G  0 disk /mounts/data
nvme0n3     259:5    0   30G  0 disk 
├─nvme0n3p1 259:6    0    1G  0 part /exercise
└─nvme0n3p2 259:7    0    1G  0 part [SWAP]
nvme0n4     259:8    0   20G  0 disk 
├─nvme0n4p1 259:9    0 1023M  0 part 
├─nvme0n4p2 259:10   0  100M  0 part [SWAP]
└─nvme0n4p3 259:11   0  100M  0 part 
nvme0n5     259:12   0   20G  0 disk 
```

### Step 2: Create a new partition

Start from a root shell. 

```bash
fdisk /dev/nvme0n5
```

**2.1. Type `g` to create a GPT partition table.**


**2.2. Type `n` to create a new partition.**

Press enter to accept the default options, and for the Last Sector, specify **+1GiB**.

Output: 
```bash
Command (m for help): g
Created a new GPT disklabel (GUID: DEEE0004-FE02-B74D-826F-E9EF7AD500E0).

Command (m for help): n
Partition number (1-128, default 1): 
First sector (2048-41943006, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-41943006, default 41943006): +1GiB

Created a new partition 1 of type 'Linux filesystem' and of size 1 GiB.
```

**2.3. Type `t` to change the partition type.**

Enter `lvm` for the partition type.

Output: 
```bash
Command (m for help): t
Selected partition 1
Partition type or alias (type L to list all): lvm
Changed type of partition 'Linux filesystem' to 'Linux LVM'.
```

**2.4. Create 3 other lvm partitions for future use.**

Since `g` was already entered, it means new partitions will automatically be part of the GPT table.

Repeat the same steps as above and type `p` to see everthing is as it should be.

Output: 
```bash
Device           Start     End Sectors Size Type
/dev/nvme0n5p1    2048 2099199 2097152   1G Linux LVM
/dev/nvme0n5p2 2099200 4196351 2097152   1G Linux LVM
/dev/nvme0n5p3 4196352 6293503 2097152   1G Linux LVM
/dev/nvme0n5p4 6293504 8390655 2097152   1G Linux LVM
```

Save the changes with `w` and list the partititions to verify the changes.

```bash
lsblk
# Output:

# NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
# nvme0n5     259:12   0   20G  0 disk 
# ├─nvme0n5p1 259:13   0    1G  0 part 
# ├─nvme0n5p2 259:14   0    1G  0 part 
# ├─nvme0n5p3 259:15   0    1G  0 part 
# └─nvme0n5p4 259:16   0    1G  0 part 
```


### Step 3: Create a physical volume with the first partition

```bash
pvcreate /dev/nvme0n5p1
# Output:

# Physical volume "/dev/nvme0n5p1" successfully created.
# Creating devices file /etc/lvm/devices/system.devices
```

Verify that the physical volume was created successfully.

```bash
pvs
# Output:

#   PV             VG Fmt  Attr PSize PFree
#  /dev/nvme0n5p1    lvm2 ---  1.00g 1.00g
```


---