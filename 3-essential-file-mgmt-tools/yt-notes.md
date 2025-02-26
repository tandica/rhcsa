# File systems 

## bean

Configure file system

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

## csg

`lvcreate` create logical volume 

`mkfs.vfat /dev/sb`

Mount file system not permanently : `mount /dev/sb /mnt-point`

To mount permanently, mohnt it directly in /etc/fstab

`umount /mnt-point` unmounts the directoryiss mounted to the specified mount point. 

