# Creating the volume group and logical volumes
## Exercise 15-2

Create a volume group, logical volume, and mount a file system on it.

### Step 1: Create the volume group

In a  root shell, verify the physical volumes created in the last exercise. 

```bash
pvs
# Output: 

#   PV             VG Fmt  Attr PSize PFree
#   /dev/nvme0n5p1    lvm2 ---  1.00g 1.00g
```

Create a volume group with the name **vgdata**. 

```bash
vgcreate vgdata /dev/nvme0n5p1 
# Output: 

# Volume group "vgdata" successfully created
```

Verify the volume group was successfully created. 

```bash
vgs
# Output: 

# VG     #PV #LV #SN Attr   VSize    VFree   
# vgdata   1   0   0 wz--n- 1020.00m 1020.00m
```

Type `pvs` again and notice the volume group appears.

```bash
pvs
# Output: 

#   PV             VG Fmt  Attr PSize PFree
#   /dev/nvme0n5p1 vgdata lvm2 a--  1020.00m 1020.00m
```


### Step 2: Create the LVM logical volume

Create an LVM logical volume with the name lvdata, which will use 50% of available disk space in the vgdata volume group.

```bash
lvcreate -n lvdata -l 50%FREE vgdata
# Output: 

# Logical volume "lvdata" created.
```
> -n specifies the name of the logical volume; -l specifies the relative size of the logical volume.

Verify the logical volume was created properly. 

```bash
lvs
# Output: 

# LV     VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
# lvdata vgdata -wi-a----- 508.00m      
```


### Step 3: Create a file system on top of the logical volume and mount it

Mount the Ext4 file system on the logical volume. Make sure to use the new names that were created.

```bash
mkfs.ext4 /dev/vgdata/lvdata   
```

Make a directory where the volume can be mounted on.

```bash
mkdir -p /volume/files 
```

Edit the **/etc/fstab** file to include the details of what needs to be mounted.

```bash
vim /etc/fstab
```

Add the below line to this file: 
`/dev/vgdata/lvdata /volume/files                                  ext4    defaults        0 0`

Verify that the /etc/fstab file does not have any errors.

```bash
findmnt --verify
```

Mount the newly added files system. 

```bash
mount -a
```

Verify the changes are correct. 

```bash
lsblk
# Output:

# nvme0n5           259:12   0   20G  0 disk 
# ├─nvme0n5p1       259:13   0    1G  0 part 
# │ └─vgdata-lvdata 253:0    0  508M  0 lvm  /volume/files
```

Looks good.

---