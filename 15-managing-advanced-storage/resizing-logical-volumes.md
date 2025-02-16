# Resizing logical volumes
## Exercise 15-3

### Step 1: Extend the volume group

In a  root shell, verify the physical volume and volume group previously created. 

```bash
pvs
# Output: 

#   PV             VG Fmt  Attr PSize PFree
#   /dev/nvme0n5p1    lvm2 ---  1.00g 1.00g

vgs
# Output: 

# VG     #PV #LV #SN Attr   VSize    VFree  
# vgdata   1   1   0 wz--n- 1020.00m 512.00m
```

Verify you have an usused partition that can be added to the volume group. In htis case, its **/dev/nvme0n5p2**.

```bash
vgcreate vgdata /dev/nvme0n5p1 
# Output: 

# nvme0n5           259:12   0   20G  0 disk 
# ├─nvme0n5p1       259:13   0    1G  0 part 
# │ └─vgdata-lvdata 253:0    0  508M  0 lvm  /volume/files
# ├─nvme0n5p2       259:14   0    1G  0 part 
```

Extend the volume group. You are extending the current volume group **vgdata** to the unused partition **/dev/nvme0n5p2**.

```bash
vgextend vgdata /dev/nvme0n5p2
# Output: 

#  Physical volume "/dev/nvme0n5p2" successfully created.
#  Volume group "vgdata" successfully extended
```

Type `vgs` to verify the volume group size has increased.

```bash
vgs
# Output: 

# VG     #PV #LV #SN Attr   VSize VFree 
# vgdata   2   1   0 wz--n- 1.99g <1.50g
```


### Step 2: Extend the logical volume

Verify the currrent size of the logical volume **lvdata**.

```bash
lvs
# Output: 

#   LV     VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
#   lvdata vgdata -wi-ao---- 508.00m  
```

Verify the current size of the file system on **lvdata**.

```bash
df -h
# Output: 

# /dev/mapper/vgdata-lvdata  466M   14K  437M   1% /volume/files     
```

Extend **lvdata** to use 50% of all disk space in the volume group. Since the volume group size was increased, the size of the logical volume will also increase.

> You should use the `-r` option to automatically resize the file system.

```bash
lvextend -r -l +50%FREE /dev/vgdata/lvdata
# Output: 

#   Size of logical volume vgdata/lvdata changed from 508.00 MiB (127 extents) to <1.25 GiB (319 extents).
#   File system ext4 found on vgdata/lvdata mounted at /volume/files.
#   Extending file system ext4 to <1.25 GiB (1337982976 bytes) on vgdata/lvdata...
# resize2fs /dev/vgdata/lvdata
# resize2fs 1.46.5 (30-Dec-2021)
# Filesystem at /dev/vgdata/lvdata is mounted on /volume/files; on-line resizing required
# old_desc_blocks = 4, new_desc_blocks = 10
# The filesystem on /dev/vgdata/lvdata is now 1306624 (1k) blocks long.

# resize2fs done
#   Extended file system ext4 on vgdata/lvdata.
#   Logical volume vgdata/lvdata successfully resized.
```

Verify again with `lvs` and `df -h`.

```bash
lvs
# Output: 

#   LV     VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
#   lvdata vgdata -wi-ao---- <1.25g   


df -h
# Output: 

# /dev/mapper/vgdata-lvdata  1.2G   14K  1.1G   1% /volume/files    
```

Notice the change in space. 


---