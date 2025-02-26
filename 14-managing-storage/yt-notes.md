# beanologk

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

## CSG 

Create new disk in the actual vm then reboot to see the changes 

`df -h` lists size, mount points and available space 

`blkid` gives UUID for disks

`lsblk` lists the disks

`partprobe` updates the ssytem with any partition changes 

Extended partition type is for logical partitions 

gpt can have up to 128 partitions







