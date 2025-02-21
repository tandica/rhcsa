# Chapter 24: Accessing Network Storage

**NFS (Network File System)**
- protocol to mount remote file systems into the local file system hierarchy
- should be used with a centralized authentication service like LDAP & Kerberos

To mount an NFS share, you need to know the names of the shares. It can be found with `showmount`.

`showmount -e nfsserver`
- shows which shares are available
- may have issues wuth NSFv4 servers that are behind a firewall
   - use NFS root mount instead or mount NFS like Exercise 24-2 in this repo

To mount NFS persistently, do it through */etc/fstab*.

An alternative to /etc/fstab is **automount**.
- using this, no file systems are mounted that are not needed
- Do this with `autofs` and automount unit files (systemd)

<br />

`autofs`
- automounts an NFS
- mounted on demand and doesn't have to be permanent
- no root permissions are required; works in user space

To define a mount in automount:
1. Edit the master config */etc/auto.master* and add the mount point and secondary file
  - *Ex:* `/nfsdata   /etc/auto.nfsdata`
2. Create the secondary file and add the subdirectory that was created in the mount point directory. Add mount options, server, and share name.


**Wildcards in automount**
- tries to moutn a share that matches the name of the directory that is accessed
- helpful for home directories to be automated for when a user logs in

`* -rw server2:/users/&`
- lines like this should go in the autofs secondary file defined in the master config (*/etc/auto.master*)
- **&** is the matching item on the remote server
  - you can also use */home* but there is more of a security risk with that

<br />

### Do you already know? Questions

1. `showmount -e` lists shares offered by an NFS server.

2. NFSv4 does not provide integration with active directory, instead it offers Kerberized security.

3. **nfs-utils** package should be installed to be able to mount NFS shares on an NFS client.

4. If you type `showmount -e` and don't get any results, it's possible that the firewall doesn't allow **showmount** traffic. To fix this, add **rpc-bind** and **mountd** services to the firewall. 

5. **nfs-server.service** is a systemd service that provides the NFS shares.

6. **_netdev** mount option is used to indicate that the file system needs network access. It's only required on old versions of RHEL.

7. To configure automount, you need to make changes in */etc/auto.master*, create a secondary file like */etc/auto.test* and then start and enable the autofs service.

8. If your directory is */myfiles*, the config file for automoutn should be name */etc/auto.myfiles*.

9. The correct syntax of a wildcard automount config is `* -rw server:/users/&`.

10. The service used to start automount is **autofs**.


### Review Questions

1. If `showmount` has no output, it's likely that **rpc-bind** and/or **mountd** are not configured in the firewall. 

2. Use `showmount -e server1` to show all available NFS mounts on server1. 

3. `mount [-t nfs] server1:/share /somewhere` mounts an NFS share that is available on server1:/share.

4. To mount all NFS shares provided by nfsserver on /shares directory, use a root mount: `mount nfsserver:/ /mnt`.

5. No additional options are needed in */etc/fstab* to ensure NFS shares are only mounted after network services have started.

6. Use the **sync** option to ensure all changes to the file system are written to the NFS server immediately. *Ex:* `server:/path/share   /mount/point   nfs   defaults,sync   0 0`.

7. **Wildcard mounts** are not supported by Systemd, only by **autofs**.

8. The main automount config file is */etc/auto.master*.

9. The service that implements automount is **autofs**.

10. No ports beed to be open in the firewall of the automount client. Only server-side needs ports open, which are port 2049 (NFS), port 111 (rpc-bind) and dynamic ports for mountd. This can be configured like this (example with mountd):
- `firewall-cmd --add-service=mountd --permanent`
- `firewall-cmd --reload`

