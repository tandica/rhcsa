# Study notes for various tasks

<br>

## Man pages 
1. `man 5 crontab` has date/time configs
2. `seinfo -t | grep ssh` shows context types for ssh. 


## General
1. To change permissions for a specific user, use `setfacl`


<br>

## To configure local repo and mount it
1. Create the directory you want to point it on `mkdir /mount-point`
2. Create the repo files for AppStream and BaseOS in */etc/yum.repos.d*
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

<br>

## To set pw properties for new users
Edit the */etc/.login.defs* file for system-wide configuration.

To verify the changes, create a new user, then run `chage -l username`.

(If you need to set pw properties for existing users, you can use `chage`)

<br>

## To create a container that runs an http server and mount it

0. Make sure you're doing these steps as a non-root user, logged in via ssh to a regular user!!!
1. Install `container-tools` package for podman
2. Create the host directory
3. Get the required httpd image
  - `podman images`
  - If not, `podman search httpd` for the required image
  - `podman pull` the image. Pull a RHEL based one if possible, even like CentOS
4. Run the container with the necessary parameters
  - `podman run`
  - for bind-mounting, ALWAYS use :Z at the end of the repo defn for SELinux labelling
    - /hostdir:/containerdir
5. **Add the port and http service to the firewall and reload it**
6. Test changes with `curl`

<br>

## Make a container start as a system user service on boot

1. Enable linger on the current user.
2. Create the directory ~/.config/systemd/user and make sure the current user owns all of these folders
3. Inside the /user folder you created, run `podman generate systemd --name containername --files` to generate the service file
4. Reload the daemon with the --user flag `systemctl --user daemon-reoad`
5. Start and enable the service file with the user flag `systemctl --user enable --now containername.service`

<br>

## To export a directory using an NFS server

1. Create the directories you want to export (/users)
2. Install nfs-utils
3. Enable and start nfs-server
4. Add the nfs, rpc-bind and mountd services to the firewall (permanently)
5. Create the /etc/exports file and edit it with the dir to be exported (users), rw permissions and no_root_squash
6. Export the directory `exportfs -r` and verify it `export -v`

<br>

## To use autofs to automount home directories of users when they access them

1. Install autofs
2. Ensure the same users exist with the same UIDs
3. Create a /users directory for the mount point
4. Edit the */etc/auto.master* with the mount point and secondary file
5. Create the secondary file /etc/auto.users and add the * directory which represents a wildcard, rw permissions, the server:directories/& symbol at the end
6. Start and enable autofs

<br>

## To set a user's home directory to something else

1. useradd command with **-m** and **-d** options to specify the home path.

<br>

## To create shared group directories 

1. Create the groups and their correspondinf directories
2. Change the owner (`chown`) of the directories to be their corresponding group 
3. Set the GID permissions (`chmod 2770`)
4. Set the sticky bit on the directories `chmod +t` if required

<br>

## Create a swap partition

1. Create a partition with `fdisk` with the type set to swap
2. Make it to a swap fs `mkswap /dev/path`  
3. Turn the swap on `swapon /dev/path`
4. **Make it persistent by mounting it by the UUID in */etc/fstab***

<br>

## Resize (add space to) existing lv that has no space left
1. Check how much space you have with `lsblk` 
2. Create a partition in which ever hard disk you have space with `fdisk` and set the type to LVM
3. On that partition, create a physical volume
4. Use that physical volume to do `vgextend` to extend the existing volume group 
5. Extend the logical volume with `lvextend -r ...`.
  - Make sure to include the -r option to extend the file system at the same time, otherwise you'll have to use another command to do it depending on what file system is used.

<br>

## Find files by a user and cp them to a directory
1. Make the destination directory
2. Use the `find` command:
  - **-user** option 
  - **-type f** option for files 
  - **-exec** to do a task with the output of files
  - `cp --parents` copy the files and maintain directory structure
  - **{}** to accept the output of the find
  - specify the destination directory
  - **\;** closes the script 
  - *Ex:* `find / -user linda -type f -exec cp --parents {} /tmp/lindafiles/ \;`

<br>

## Set up the network config
1. Use `nmtui` 
2. Restart the NetworkManager

<br>

## FTP service configuration
1. Install and enable ftp service (vsftp)
2. Add the ftp service to the firewall
3. Edit the vsftpd config file, allow anonymous download
4. If you need to set a custom path for the download, use `anon_root=/path`
5. Restart the service
6. Create a test file in */var/ftp/pub/* and try to access it with `ftp localhost`. The username should be "anonymous". 
