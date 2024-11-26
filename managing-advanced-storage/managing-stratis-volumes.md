# Managing Stratis volumes
## Exercise 15-5

### Step 1: Create a new disk 

Create a fresh disk to do the Stratis exercise.

**1.1. Power off the virtual machine.**

**1.2. Go to the vm settings and add a new hard disk. Power on the virtual machine.**

**1.3. Run the `lsblk` command to confirm the newly created disk**

```bash
lsblk
# Output:

NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0          11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
nvme0n1     259:0    0   80G  0 disk 
├─nvme0n1p1 259:1    0    1G  0 part /boot
├─nvme0n1p2 259:2    0    8G  0 part [SWAP]
└─nvme0n1p3 259:3    0   71G  0 part /
nvme0n2     259:4    0   45G  0 disk /mounts/data
nvme0n3     259:5    0   30G  0 disk 
├─nvme0n3p1 259:6    0    1G  0 part /exercise
└─nvme0n3p2 259:7    0    1G  0 part [SWAP]
nvme0n4     259:8    0   20G  0 disk 
├─nvme0n4p1 259:9    0 1023M  0 part 
├─nvme0n4p2 259:10   0  100M  0 part [SWAP]
└─nvme0n4p3 259:11   0  100M  0 part 
nvme0n5     259:12   0   20G  0 disk 
nvme0n6     259:17   0   20G  0 disk 
```


### Step 2: Install and enable Stratis

Verify the currrent size of the logical volume **lvdata**.

```bash
dnf -y install stratis-cli

dnf -y install stratisd

systemctl enable --now stratisd
```


### Step 3: Create a Stratis pool

Create a pool using the entire new disk.

```bash
stratis pool create mypool /dev/nvme0n6
```

Verify the creation of the pool.

```bash
stratis pool list
# Output:

# Name              Total / Used / Free    Properties                                   UUID   Alerts
# mypool   20 GiB / 534 MiB / 19.48 GiB   ~Ca,~Cr, Op   ef38b3ca-10ff-4602-99c9-8e11cc83123a 
```

### Step 4: Create a Stratis file system

Note that you don't need to specify a size for the file system.

```bash
stratis fs create mypool stratis1
```

Verify the creation of the file system.

```bash
stratis fs list
# Output:

# Pool     Filesystem   Total / Used / Free / Limit            Created           Device UUID                                
# mypool   stratis1     1 TiB / 546 MiB / 1023.47 GiB / None   Nov 25 2024 20:27   /dev/stratis/mypool/stratis1   4c6290f5-3537-42cd-a0b3-74862555dd98
```

### Step 5: Mount the file system

Create a directory for the mount point.

```bash
mkdir /stratis1
```

Get the UUID by listing the file systems again.

```bash
stratis fs list
# Output:

# Pool     Filesystem   Total / Used / Free / Limit            Created           Device UUID                                
# mypool   stratis1     1 TiB / 546 MiB / 1023.47 GiB / None   Nov 25 2024 20:27   /dev/stratis/mypool/stratis1   4c6290f5-3537-42cd-a0b3-74862555dd98
```

Edit the **/etc/fstab** file.

```bash
vim /etc/fstab
```

Add the below line: 
`UUID=4c6290f5-3537-42cd-a0b3-74862555dd98 /stratis1               xfs     defaults,x-systemd.requires=stratisd.service 0 0`

Verify the file has no errors, then mount it. 

```bash
findmnt --verify

mount -a
```

Verify the file system is founted.

```bash
df -h
# Output:

# /dev/mapper/stratis-1-ef38b3ca10ff460299c98e11cc83123a-thin-fs-4c6290f5353742cda0b374862555dd98  1.0T  7.2G 1017G   1% /stratis1
```

### Step 5: Create and explore the snapshot feature

Copy some files to the **/stratis1** directory.

```bash
cp /etc/[a-f]* /stratis1
```

Make a snapshot.

```bash
stratis filesystem snapshot mypool stratis1 stratis1-snap
```

Get stats about the current file system usage. You can see the snapshot there.


```bash
stratis filesystem list
# Output:

# Pool     Filesystem      Total / Used / Free / Limit            Created             Device                              UUID                                
# mypool   stratis1        1 TiB / 546 MiB / 1023.47 GiB / None   Nov 25 2024 20:27   /dev/stratis/mypool/stratis1        4c6290f5-3537-42cd-a0b3-74862555dd98
# mypool   stratis1-snap   1 TiB / 546 MiB / 1023.47 GiB / None   Nov 25 2024 20:43   /dev/stratis/mypool/stratis1-snap   40bed651-12d5-4999-b6ac-a2dc0793b4aa
```

> The above command is the same as `stratis fs list`.

Remove all files that start with an "a".

```bash
rm -f /stratis1/a*
```

Mount the snapshot and verify that files that start with "a" are still in the /mnt directory.

```bash
mount /dev/stratis/mypool/stratis1-snap /mnt

ls -l /mnt/a*
# Output:

# -rw-r--r--. 1 root root    16 Nov 25 20:40 /mnt/adjtime
# -rw-r--r--. 1 root root  1529 Nov 25 20:40 /mnt/aliases
# ...
```

### Step 5: Reboot the server and verify that the Stratis volume is still mounted

```bash
df -h
# Output:

# /dev/mapper/stratis-1-ef38b3ca10ff460299c98e11cc83123a-thin-fs-4c6290f5353742cda0b374862555dd98  1.0T  7.2G 1017G   1% /stratis1
```

---