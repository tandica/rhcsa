# Chapter 14: Managing Storage

To use a hard drive, it needs to have partitions.

**Partition**: subdivisions of a storage device that allow the OS to organize and manage data effieciently.

**GPT (GUID Partition Table)**
- standard for partitioning a storage device
- part of UEFI and replaces MBR (Master Boot Record)
- allows a max of 128 partitions to be created
- doesn't have a 2tb limit
- each partition can be up to 8 zezibytes

Linux uses the binary number (Mib, Kib, etc.) for the storage amount standard.

2 different types of partitions can be used:
- **GPT** - modern solution
- **MBR** - old, max of 4 partitions

2 utilities for partitioning: 
- **fdisk** 
  - used to create and manage both MBR & GPT partitions
- **gdisk**
  - create and manage only GPT partitions

**parted** - a partitioning utility, but not widely used as it does not have advanced functionality.

`lsblk` displays a list of all disk devices on the system.

** If you want to go beyond the 4 partitions of an MBR disk, you have to create an **extended partition**, then a **logical partition**.
- all logical partitions exist within an extended partition
- if the extended partition is damages, you will have a problem with all the logical partitions inside it

<br/>

- if you need more than 4 storage allocations units, it might be better to use LVM
- if you have a completely new disk, it might be better to create GPT partitions

** If fdisk prints a msg that it could't update the partition table, use the `partprobe` command to manually update the partition table, then `lsblk` to verify changes. 

`partprobe` is used to inform the OS kernel of partition table changes without needing to reboot. *Ex:* `partprobe /dev/nvm0n2` notifies the kernel of the update.

** **Never use *gdisk* on a disk that has been formatted with *fdisk* and already contains *fdisk* partitions!!! It will mess the computer up!** *gdisk* detects that MBR is present and it will try to convert it to gdisk which will cause the computer not to boot. 

Revelvant GPT partition types:
- **8200: linux swap**
- **8300: linux file system**
- **8e00: linux LVM** 

These are the same partition types in MBR.

`parted` can be used to create partitions but lacks support for advanced features. 

A partition by itself is not useful, it needs a **file system**. 

<br/>

### File System

**XFS** - defsultt file system in RHEL9

**Ext4** - default file system in previous versions of RHEL; still supported in RHEL9

**Ext3** - old version of Ext4. No need to use this on RHEL9.

**Ext2** - basic file system developed in the early 90s. No eed to use this on RHEL9.

**BtrFS** - new file system that is *not* supported in RHEL9.

**NTFS** - a windows file system that is *not* supported in RHEL9.

`mkfs` formats partition with a supported file system.

`tune2fs` is a tool for managing Ext4 file system properties.
  - `tune2fs -l` shows file system properties
  - **-o** option sets the default file system mount options
  - `tune2fs -O featurename ` swicthes on a file system feature
  - `tune2fs -O ^featurename` turns file system feature off 
  - `tune2fs -L label` sets the label on a file system
    - e2label does the same thing

**XFS file system** has a different set of tools to manage its properties. To change properties, use **xfs_admin**.

**Swap partitions**
- swap space is normally allocated on a disk device 
- it is a way to improve linux kernel memory usage 
  - if a shortage of physical RAM occurs, non-recently used memory pages can be moved to swap to make more RAM available for programs.
- swap shouldnt be used intensively
- good option for memory shortages

**Swap files**
- can be used if there's not enough disk spacce to create a swap partition
- doesn't make a difference to use a swap file or swap partition
- To make a swap file:
  - `dd if=/dev/zero of=swapfile bs=1m count=100`
    - this adds 100 blocks with size 1MiB from the */dev/zero* device to the */swapfile*
    - makes a file that can be configured as swap
  - `mkswap /swapfile`
    - marks the file as a swap file
  - `swapon /swapfile`
    - activtaes the swap file
  - Edit */etc/fstab* to include the line `/swapfile none swap defaults 0 0`

** Creating a partition and putting a file system on it is not enough to start using it - **you have to mount it**.

To mount a file system, you need this info:
  - what to mount
    - mandatory; name of device that needs to be mounted
  - where to mount it
    - mandatory; directory where device should be mounted
  - what file system to mount
    - optional; file system type
    - optional because the `mount` command can detect which file system is on the device
  - mount options
    - optional

`mount` manually mounts a file system. *Ex:* `mount /dev/sdb /mnt` mounts the file system on /dev/sdb to /mnt.

`umount` disconnects the mount manually. It can beused with the name of the device or the mount point. *Ex:* `umount /dev/sdb` OR `umount /mnt`.

Using the above commands is not recommended when a dynamic storage topology is used. **It's better to use UUID instead of device names**.

To mount with a UUID: `mount UUID=abc123 /mnt`. This way is better for automated mounts.

`blkid` shows an overview of current file systems and the **UUID** used by that file system.

Mounting manually is not recommended. Mount automatically throght the */etc/fstab* file.

`findmnt --verify` verifies */etc/fstab* syntax and alerts you if anything is incorrect.

`mount -a` mounts all file systems in */etc/fstab* that are not currently mounted.

You can use */etc/fstab* to create Systemd mounts
- used as an input file
- Systemd is ultimately responsible for mounting file systems
- you can mount a file in */etc/systemd/system*

`df -h` shows disk space usage and where the file system is mounted on. It verifies if the partition was mounted properly.

<br />


### Do you already know? Questions

1. Using GUID does not make access time to a directory faster. Its advantages are:
- 8ZiB can be taken by a partition
- a backup copy of the partition table is automatically created
- there can be upto 128 partitions

2. You cannot change an MBR disk to GPT.

3. **Partition type 82** is used to create a swap file.

4. The default disk device name in KVM vitual machines is */dev/vda*.

5. A disk can only have one partition table, so it's not possible to have bith MBR and GPT partitions on the same disk.

6. **XFS** is the default file system in RHEL 9.

7. `blkid` shows the current UUIDs set to the file systems, as well as their label if they have one.

8. To mount a file system in */etc/fstab*, use UUID=xxxx in the device column. 

9. `findmnt --verify` is used to verify the contents of */etc/fstab*. `mount -a` does the same, but only works on devices that are not currently mounted.

10. When creating a Systemd mount unit file, the [Install] section is only required if you want to enable the mount unit file.


### Review Questions

1. To create a GUID partition, you can use **fdisk**, **gdisk** or **parted**.

2. To create an MBR partition, you can use **fdisk** or **parted**.

3. The default file system in RHEL9 is **XFS**.

4. */etc/fstab* automatically mounts partitions while booting. 

5. If you don't want a file system to be mounted automatically while booting, use the **noauto** mount option.

6. To format a partition that has type 82 (swap) with the appropriate file system, use `mkswap`.

7. To test a partition for automatic mounting without actually rebooting, use `mount -a` or `findmnt --verify`.

8. If you don't want to specify anything in the mkfs command, Ext2 will be used by default. Always explicitly specify either **Ex4** or **XFS**.

9. To format an Ext4 partition, use `mkfs.ext4` or `mkfs -t ext4`.

10. To find UUIDs for all devices on your computer, use `blkid`.
