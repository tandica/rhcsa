# Create a swap partition
## Exercise 14-6


### Step 1: Create a new partition

```bash
sudo -iu root 

fdisk /dev/nvme0n3
```

Type `n` to create a new partition and choose default options for the **partition number** and **first sector**.

Type `+1GiB` for the **last sector** option.

Output: 
```bash
Command (m for help): n
Partition number (2-128, default 2): 
First sector (2099200-62914526, default 2099200): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2099200-62914526, default 62914526): +1GiB

Created a new partition 2 of type 'Linux filesystem' and of size 1 GiB.
```


### Step 2: Change the partition to a swap partition type

Still in the **fdisk** editor, type `t` to change the partition type. 

Choose the default partition and type `swap`.

Output: 
```bash
Command (m for help): t
Partition number (1,2, default 2): 
Partition type or alias (type L to list all): swap

Changed type of partition 'Linux filesystem' to 'Linux swap'.
```

Type `w` to save and exit.

Output: 
```bash
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

> Since I'm using **fdisk**, typing `swap` to change the partition to a swap partition is correct. If I was using **gdisk**, I would need to type `8200` in that option. 


### Step 3: Format the partition as a swap space

```bash
mkswap /dev/nvme0n3p2
# Output:

# Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
# no label, UUID=19e6e447-f8fe-47b9-8b74-f18de4c74a2b
```

Check if the changes were applied.

```bash
lsblk -f
# Output:

# nvme0n3
# │                                                                             
# ├─nvme0n3p1
# │                                                                             
# └─nvme0n3p2
#      swap   1             19e6e447-f8fe-47b9-8b74-f18de4c74a2b     
```

You can also use `blkid` to check this. 


### Step 4: Activate the swap space

The below command shows the amount of swap space that is allocated. 

```bash
free -m 
# Output:

#                total        used        free      shared  buff/cache   available
# Mem:            3626        1559        1203          17        1127        2066
# Swap:           8191           0        8191
```

> `swapon` activates the newly allocated swap space of 1GiB that was made when the partition was created.

```bash
swapon /dev/nvme0n3p2
# Output:

#                total        used        free      shared  buff/cache   available
# Mem:            3626        1559        1203          17        1127        2066
# Swap:           8191           0        8191
```

Verify that more space has been added to the swap space. 

```bash
free -m 
# Output:

#                total        used        free      shared  buff/cache   available
# Mem:            3626        1542        1217          17        1129        2083
# Swap:           9215           0        9215
```


### Step 5: Ensure that swap space is available after a reboot

To do this, edit the **/etc/fstab** file with the below line. 

`/dev/nvme0n3p2 none                                               swap    defaults        0 0`

```bash
vim /etc/fstab
```

After the change is added, verify the **/etc/fstab** file does not have any errors. 

```bash
findmnt --verify 
# Output:

# none
#    [W] target specified more than once

# 0 parse errors, 0 errors, 1 warning
```

---