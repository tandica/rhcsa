# Study notes for various tasks

<br>

## Man pages 
1. `man 5 crontab` has date/time configs
2. `seinfo -t | grep ssh` shows context types for ssh. 
3. `man semanage port` gives examples of the command to add ports for SELinux
4. Firewall custom exceptions - use rich rules: `man firewalld.richLanguage`
5. `man test` and `man bash` (conditional expression) for scripting options for file
6. Loops examples: `cat /etc/profile | grep for`

## General
1. To change permissions for a specific user, use `setfacl`
2. Force delete a container: `podman rm -f`
3. Ping the other server on the exam with `ping` to test connectivity

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

## Enable root login via SSH
1. Edit the /etc/ssh/sshd_config file in the server you want access to
2. Set PermitRootLogin to yes

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
    - /hostdir:/containerdir:Z
  - dont forget to add the image at the end of the command!!!
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

## Create a (rootless) container with env variables (mysql) & start it as a system user service on boot

1. Start as a non-root user!! Use ssh to change to it
2. Create the host directory
3. Pull the image and verify
4. Run the container with `podman run`
- need to add env variables for specifying the root pw using **-e** option
  - `... -e MYSQL_ROOT_PASSWORD=password ...`
5. Verify its working, then create the *~/.config/systemd/user* file for the systemd stuff
6. Enable linger for the current user
7. Generate the systemd files
8. Reload the daemon and enable/start the service with the user flag

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
5. Extend the logical volume with `lvextend -r ... /dev/vg/lv`.
  - Make sure to include the -r option to extend the file system at the same time, otherwise you'll have to use another command to do it depending on what file system is used.
  - ensure to provide the correct file path for the lvm (/dev/rhel/root --> /dev/vg/lv)

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

<br>

## Tuned
1. Install, enable and start tuned
2. `tuned-adm recommend` gets the recommended profile
3. `tuned-adm profile xxx` sets the profile
4. Verify with `tuned-adm active`

<br>

## Time synchronization with another server
1. Install, enable and start the chrony service
2. Edit the /etc/chrony.conf file
- Comment out the pool line 
- Add "server" then the server name. Keep the iburst at the end 
3. Add **ntp** to the firewall 
4. Restart the chronyd service
5. Verify the changes with `chronyc source`

<br>

## Connect 2 servers
1. Configure the required networking with `nmtui`
2. Edit the /etc/hosts file on each server and add a line for the respective server along with its ip address
- `192.168.1.20   server2.example.com   server2`

<br>

## Allow a user to run only one command

1. Edit the sudoers file with `visudo`
  - copy the same structure as the root, but replace the third column with NOPASSWD: /usr/bin/cmd
  - cmd should be the command, you can get the pull path using `which`
2. Modify the user and specify the path to the cmd allowed
  - `usermod -s /usr/bin/passwd` username to allow the user only to change their password

<br>

## Build container image

1. Locate the Containerfile and `cat` it to verify the content
2. Navigate to the directory and build the image
- `podman build -t name:version .` 
  - -t option give the image a name and version
  - you must specify the directory where the image is, in this cae its "."
  - otherwise specify the path to the Containerfile with -f 

<br>

## Set timezone and NTP

1. Install chronyd service
2. Use `timedatectl set-timezone America/xxx`
3. Set NTP: `timedatectl set-ntp 1`

<br>

## Services which might be needed:
- nfs-utils & autofs
- containter-tools
- httpd
- vsftpd
- chronyd
- mandb 

<br>

## Scripting
- To assign the output of a command to a variable, use $(cmd)
  - LOGGED_IN=$(users)
- for `if` statement, don't use sqaure brackets [] for running commands
  - only use it for evaluations like if `"$1" == "$2"`
  - also can be used for **-f** and **-z** options
    - **-f** checks is a file exists and its regular
    - **-z** checks if a string is empty
  - square brackets shouldn't be mixed with pipes | 
- always put double quotes around variables and arguments: "$1" "$LOGGED_IN"

<br>

