# Removing a volume group from a physical volume
## Exercise 15-4


### Step 1: Create the volume group and extend it.

In a root shell, create a volume group with the name *vgdemo*, using one of previously created unused partitions.

```bash
vgcreate vgdemo /dev/nvme0n5p3
# Output: 

# Physical volume "/dev/nvme0n5p3" successfully created.
# Volume group "vgdemo" successfully created
```

Create a logical volume with a size of 400MB. 

```bash
lvcreate -L 400MB -n lvdemo /dev/vgdemo
# Output: 

# Logical volume "lvdemo" created.
```

Extend the volume to the other unused partition.

```bash
vgextend vgdemo /dev/nvme0n5p4
# Output: 

# Physical volume "/dev/nvme0n5p4" successfully created.
# Volume group "vgdemo" successfully extended
```

Type `pvs` again and notice the volume group appears.

```bash
pvs
# Output: 

# PV             VG     Fmt  Attr PSize    PFree   
# /dev/nvme0n5p1 vgdata lvm2 a--  1020.00m       0 
# /dev/nvme0n5p2 vgdata lvm2 a--  1020.00m  764.00m
# /dev/nvme0n5p3 vgdemo lvm2 a--  1020.00m  620.00m
# /dev/nvme0n5p4 vgdemo lvm2 a--  1020.00m 1020.00m
```


### Step 2: Extend the logical volume

Extend the logical volume by 200MB to /dev/nvme0n5p4.

```bash
lvextend -L +200MB /dev/vgdemo/lvdemo /dev/nvme0n5p4
# Output: 

# Size of logical volume vgdemo/lvdemo changed from 400.00 MiB (100 extents) to 600.00 MiB (150 extents).
# Logical volume vgdemo/lvdemo successfully resized.
```

Verify the extent usage on the devices. 

```bash
pvs
# Output: 

# PV             VG     Fmt  Attr PSize    PFree  
# /dev/nvme0n5p1 vgdata lvm2 a--  1020.00m      0 
# /dev/nvme0n5p2 vgdata lvm2 a--  1020.00m 764.00m
# /dev/nvme0n5p3 vgdemo lvm2 a--  1020.00m 620.00m
# /dev/nvme0n5p4 vgdemo lvm2 a--  1020.00m 820.00m
```


### Step 3: Create a file system on top of the logical volume and mount it temporarily

Mount the Ext4 file system on the logical volume. Make sure to use the new names that were created.

```bash
mkfs.ext4 /dev/vgdemo/lvdemo   
```

Mount it temporarily.

```bash
mount /dev/vgdemo/lvdemo /mnt
```

Verify disk space usage.

```bash
df -h
# Output: 

# /dev/mapper/vgdemo-lvdemo  574M   24K  532M   1% /mnt
```

Use the following command to ensure that file data is on both physical volumes.


```bash
dd if=/dev/zero of=/mnt/bigfile bs=1M count=500
```

> if=/dev/zero: Specifies the input file. /dev/zero is a special file in Linux that generates a continuous stream of zero bytes.

> of=/mnt/bigfile: Specifies the output file. In this case, the file bigfile in /mnt will be created or overwritten.

> bs=1M: Sets the block size to 1 MB. Each read/write operation will handle 1 MB of data at a time.

> count=1100: Specifies the number of blocks to process. With a block size of 1 MB, this means 1100 MB (or ~1.1 GB) of data will be written


### Step 4: Remove a physical volume 

Move everything from **/dev/nvme0n5p4** to **/dev/nvme0n5p3**.

```bash
pvmove -v /dev/nvme0n5p4 /dev/nvme0n5p3
# Output:

# Creating logical volume pvmove0
# activation/volume_list configuration setting not defined: Checking only host tags for vgdemo/lvdemo.
# Moving 50 extents of logical volume vgdemo/lvdemo.
# activation/volume_list configuration setting not defined: Checking only host tags for vgdemo/lvdemo.
# Archiving volume group "vgdemo" metadata (seqno 4).
# Creating vgdemo-pvmove0
# Loading table for vgdemo-pvmove0 (253:2).
# Loading table for vgdemo-lvdemo (253:1).
# Suspending vgdemo-lvdemo (253:1) with device flush
# Resuming vgdemo-pvmove0 (253:2).
# Resuming vgdemo-lvdemo (253:1).
# activation/volume_list configuration setting not defined: Checking only host tags for vgdemo/pvmove0.
# Creating volume group backup "/etc/lvm/backup/vgdemo" (seqno 5).
# Checking progress before waiting every 15 seconds.
# /dev/nvme0n5p4: Moved: 90.00%
# Polling finished successfully.
```

Verify that /dev/nvme0n5p4 is now unused.

```bash
pvmove -v /dev/nvme0n5p4 /dev/nvme0n5p3
# Output:

# PV             VG     Fmt  Attr PSize    PFree   
# /dev/nvme0n5p1 vgdata lvm2 a--  1020.00m       0 
# /dev/nvme0n5p2 vgdata lvm2 a--  1020.00m  764.00m
# /dev/nvme0n5p3 vgdemo lvm2 a--  1020.00m  420.00m
# /dev/nvme0n5p4 vgdemo lvm2 a--  1020.00m 1020.00m
```

No space is being used in this physical volume, so we can delete it.

```bash
vgreduce vgdemo /dev/nvme0n5p4
# Output:

#   Removed "/dev/nvme0n5p4" from volume group "vgdemo"
```

Verify that its been removed from the volume group. 

```bash
vgreduce vgdemo /dev/nvme0n5p4
# Output:

#    PV             VG     Fmt  Attr PSize    PFree  
# /dev/nvme0n5p1 vgdata lvm2 a--  1020.00m      0 
# /dev/nvme0n5p2 vgdata lvm2 a--  1020.00m 764.00m
# /dev/nvme0n5p3 vgdemo lvm2 a--  1020.00m 420.00m
# /dev/nvme0n5p4        lvm2 ---     1.00g   1.00g
```


---