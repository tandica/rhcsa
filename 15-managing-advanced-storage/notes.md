# Chapter 15: Managing Advanced Storage

**LVM (Logical Volume Manager)**
- partitions are not flexible, which led to the creations of LVM
- with LVM, you can dynamically grow a partition that is running out of disk space

**Storage devices** need to be flagged as physical volumes to be used in an LVM, After that, the storage device can be added to a **volume group**. 

**Volume group**
- abstraction of all available storage
  - abstraction means that the volume group can be resized and is not fixed
  - if you're running out of space on a logical volume, you tae available disk space automatically from the volume group
  - if there's no disk space in the volume group, add a physical volume

**Logical volumes** are on top of volume groups.
- they get space from the volume groups
- file systems are created on here
- file system must support resizing for it to occur

![lab-18-2](../img/lvm-diagram2.drawio.png)



