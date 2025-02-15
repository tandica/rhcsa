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
- 8200: linux swap
- 8300: linux file system
- 8e00: linux LVM 

These are the same partition types in MBR.

`parted` can be used to create partitions but lacks support for advanced features. 

A partition by itself is not useful, it needs a **file system**. 

