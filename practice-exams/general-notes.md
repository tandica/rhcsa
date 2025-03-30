# Study notes for various tasks

### To configure local repo and mount it
1. Create the directory you want to point it on `mkdir /mount-point`
2. Create the repo file in */etc/yum.repos.d*
3. Edit it in this format and save:

```vim
[title]
name=reponame
baseurl=file:///mount-point
enabled=1
gpgcheck=0
```
4. Test mount with `mount /dev/source /mount-point`
5. Add the mount persistently in */etc/fstab*
  - note the file system, if you need to mount an ISO, use filesystem **iso9660**
  - **if you're not sure of the file system, you can use `blkid` and it will show you it under "TYPE"**
  - for ISO, it can only be mounted as "ro" (read-only), this needs to be specified instead of putting `defaults`
  - if the question asks you to "automatically mount", you can put "auto" in the `defaults section as well
    - `ro,auto`
6. Check for errors in the mount: `mount -a`
7. Verify the files are in the mount-point: `ls -l /mount-point`. `reboot` to verify persistence.

