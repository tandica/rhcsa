# NFS and Autofs

## beanologi

### Create NFS server

`dnf insytall -y nfs-utils` installs packages for NFS.

Create a new directory such as `mkdir -p /srv/nfs/fun`.

Create a new group: `groupadd -g 12345 fun`. **-g** is for the group id and the group is named *fun*.

Add user admin to the fun group: `usermod -aG fun admin`.

Check that admin is part of the fun group: `id admin`. It should list all groups the user is part of. 

Edit the /etc/exports file and write the export directory (/srv/nfs/fun):
`/srv/nfs/fun     10.0.0.0/24(sync,rw)`

Make a firewall exception:: `firewall-cmd --permanent --add-service nfs` then reload it. 

Enable the server: `systemctl enable --now nfs-server`.

### Mount and unmount NFS

Create a mount point: `mkdir -p /mnt/nfs/dir`.

Mount the nfs server: `mount -t nfs server1:/srv/nfs/fun /mnt/nfs/dir`. The **-t** option specifies that the filesystem type is nfs. 

You need to modify the permissions on the nfs server directory (/srv/nfs/fun) to allow file creation. 

`chmod g+w /srv/nfs/fun` will do the above. 

You need to unmount with `umount /mnt/nfs/dir` and add the mount to the */etc/fstab* file for it to be permanent. 

Test the */etc/fstab* with `mount -a`, which mounts everything that isn't yet mounted and outputs errors if there are any. 

`mount -v | grep nfs` will search for an nfs mount and output it.

### Autofs

<br>

## CSG 



<br>

## DexTutor



