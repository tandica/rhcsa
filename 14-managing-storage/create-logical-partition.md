# Create a logical partition
## Exercise 14-2

How to create a logical partition.

### Step 1: Create an extended partition    

To create a logical partition, you must first create an extended partition.

Run the `fdisk` command with the newly created disk.

```bash
fdisk /dev/nvme0n2
```

Type `n` to create a new partition.

Type `e` to choose an extended partition. 

Press enter to accept the default partition, first sector and last sector configurations.

Output: 
```bash
Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): e
Partition number (2-4, default 2): 
First sector (4196352-94371839, default 4196352): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-94371839, default 94371839): 

Created a new partition 2 of type 'Extended' and of size 43 GiB.
```

An extended partition has been created.

### Step 2: Create the logical partition within the extended partition

Press `n`, still from the fdisk interface. By default, it will suggest adding a logical partition with partition number 5.

```bash 
Command (m for help): n
All space for primary partitions is in use.
Adding logical partition 5
First sector (4198400-94371839, default 4198400): 
```

Accept the default first sector, then enter **+1G** for the last sector. Type `w` to save the changes. 

```bash 
Command (m for help): n
All space for primary partitions is in use.
Adding logical partition 5
First sector (4198400-94371839, default 4198400): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4198400-94371839, default 94371839): +1G

Created a new partition 5 of type 'Linux' and of size 1 GiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

---