# GPT and MBR Partitions / File Systems

## beanologi

In fdisk, you can use **m** to access a help page 

There are 2. types of partition tables - gpt and mbr 

in fdisk, create an mbr partition scheme by typing **o**. 

mbr only supports 4 partitions with a primary patition type

To write the changes to the disk, type **w**. it automatically exits after changes are written 

Type **g** for gdisk partition

`fdisk -l /dev/disk-name` lists the disks and partitions 

cfdisk - like fdisk ur has a better UI 

change partition type in fdisk - type **t** 

delete a partition : **d** 

#### Configure file system

fat32 partition type has to be defined. for xfs and ext4, linux type is ok

`mkfs.vfat /dev/sb` formats file system to vfat

label vfat file systems: `fatlabel /dev/sb`

`mkfs.ext4 /dev/sb` create ext4 file system

label ext4 file system `e2label /dev/sb MYEXT4`

`mkfs.xfs /dev.sb` formsts xfs file system. add -f option to force it

label xfs file system: `xfs_admin -L MYXFS /dev/sb`

`blkid` also shows labels and file type. 

to mount, edit the /etc/fstab file

You can mount using label or UUID 

`df` shows whats currently mounted. 

<br>

## CSG 

Create new disk in the actual vm then reboot to see the changes 

`df -h` lists size, mount points and available space 

`blkid` gives UUID for disks

`lsblk` lists the disks

`partprobe` updates the ssytem with any partition changes 

Extended partition type is for logical partitions 

gpt can have up to 128 partitions

`lvcreate` create logical volume 

`mkfs.vfat /dev/sb`

Mount file system not permanently: `mount /dev/sb /mnt-point`

To mount permanently, mohnt it directly in /etc/fstab

`umount /mnt-point` unmounts the directoryiss mounted to the specified mount point. 

`fsck.vfat /dev/sb` runs a file system check to check if there are errors, repair them and update the file system structure if needed. Only run this command when the file ysstem is **unmounted**. 

To run a filesystem check on any type of file system, do `fsck /dev/sb`.

XFS file system check: `xfs_repair /dev/sb`.

`xfs_info` shows info related to the current xfs filesystem.

<br>

## DexTutor 

n/a

