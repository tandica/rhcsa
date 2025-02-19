# Create a file system
## Exercise 14-5

Create a file system on the partition from exercise 14-1.

### Step 1: Create a file system


```bash
sudo -iu root 

mkfs.xfs /dev/nvme0n2
# Output: 

# meta-data=/dev/nvme0n2           isize=512    agcount=4, agsize=2949120 blks
#          =                       sectsz=512   attr=2, projid32bit=1
#          =                       crc=1        finobt=1, sparse=1, rmapbt=0
#          =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
# data     =                       bsize=4096   blocks=11796480, imaxpct=25
#          =                       sunit=0      swidth=0 blks
# naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
# log      =internal log           bsize=4096   blocks=16384, version=2
#          =                       sectsz=512   sunit=0 blks, lazy-count=1
# realtime =none                   extsz=4096   blocks=0, rtextents=0
```

> You can also accomplish this with the command `mkfs -t xfs /dev/nvme0n2`.


---