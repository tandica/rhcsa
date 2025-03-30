# Theoretical Exam

### Write what you think the answer should be for each question

1. To create a **shared group environment** where members of the "sales" group can share permissions with each other, you can:
- ensure the group "sales" exists by printing the existing groups: `cat /etc/group`
  - if it doesn't, use `groupadd sales` to add it
- if the users already exist, use `usermod -aG sales user1` to add them to the group
  - if they dont exist, use  `useradd -G sales user1`
- create the shared directory
- set the group ownership of that directory to sales like `chown :sales /shared-sales-dir`
- ensure that all new directories and files inherit the group ownership of sales: `chmod 2770 /shared-sales-dir`
  - the 2 in the above command sets the GID (group id)
    -similarly, for user owner ineritance, it would be 4 and for sticky bit (restricting file deletion to owners), it would be 1


2. To change the **host name** persistently, do `hostnamectl set-hostname name`


3. Create a **logical volume** and mount it as an Ext file system on /data:
LV has 3 parts, phycial volume, volume group, logical volume. 
- add a new hard disk if needed ??
- you need to set the specified extent size on this step with physical volumes. create pv with `pvcreate -s 8MiB/dev/path` 
- create vg with `vgcreate nameofvg /dev/path` 
- create lv with `lvcreate -n myh_lv -L 500M`, this specifies the name "my_lv" and size of 500M. 
- make the lv have an ext4 file system with `mkfs.ext4 /dev/path/lv`
- mount it persistently in /etc/fstab and specify ext4 as the file system and /data as the mount point


4. If while booting, your server gives an error and shows "**enter root pw for maintenance**", it means the system has gone into emergency mode or similar and there is some error relating to mounting in */etc/fstab*, the file system, or corrupted system file. To fix it, it depends on what tasks you've done recently. If you mounted something, it may be incorrect. You can use `fsck /dev/path` to check the filesystem integrity and fix any isuues. Check if the root file system is mounted as read/write, if not, change it to be this way `mount -o remount,rw /`.


5. To access a repo that is available on ftp://server.com/pub/repofiles, you need to:
- create the dnf config file: `vim /etc/yum.repos.d/ftp-file.repo
- in the config file, add the name of the repo, the baseurl, enable=1, and gpgcheck=0. The title should be in square brackets [ftp-file]
- check if the repo is listed `dnf repolist`
- install the required repo with `dnf install -y reponame`


6. To schedule a command that should be executed everyday at midnight as user bob, you can use **crontab** to create a cron job and specify that the user is bob. You can also switch the user to bob and create the cron job. 
- create the cron job file: `crontab -e -u bob`
- add the fields defining the time of the job **(CHECK: `man 5 crontab` for the definition of times!!!!)**
- save file and type `crontab -l` to verify the job was added


7. To create a user that is not allowed to login, use `useradd user1 -s /sbin/nologin`. 


8. If I have configured my **webserver to listen at port 8082** and it doesn't start anymore, I should:
- check the status and logs of httpd service
- confirm if that port is allowed/added by the firewall
- check httpd config file (*/etc/httpd/conf/httpd.conf*) where that port was defined for any errors
- restart the httpd service
- update SELinux policy 


9. To **change root password**:
- reboot and access the grub2 menu with ESC. press e to edit 
- at the end of the line that starts with Linux, add `init=/bin/bash`
- ctrl + x to boot with these params
- mount with read write: `mount -o remount,rw /`
- change the pw with passwd
- create a file to relabel the SELinux content `touch /.autorelabel`
- start the server with pid 1 as systemd `exec /usr/lib/systemd/systemd`
- reboot


10.To use the best performance profile on a server, use **tuned**:
- make sure it's installed, enabled and started!!!
- check the recommended profile `tuned-adm recommend` 
- change it to the recommended profile `tuned-adm profile virtual-guest`
- verify that the profile changed `tuned-adm active`


11. To find an rpm package that you don’t know the name of, but you know has *sealert*, you can use `dnf search sealert` or `dnf provides */sealert`. 


12. To locate all files containing the text "root" in the /etc directory, use the **`grep`** command, and search recursively for "root" in the specified directory: `grep -r "root" /etc`.


13. If you get a "nothing appropriate" msg for `man -k user`, you can fix it by updating the man db:
- run `mandb` 
- if the issue still exists, ensure the repos **man-db** and **man-pages** are installed


14. To add a user to a **new secondary group** without modifying the existing secodary group assignments:
- create the group: `groupadd sales`
- add the existing user to it with usermod: `usermod -aG sales bobbi`
  - **-a** option means "append". This will ensure it doesn't modify existing secondary group assignments
  - **-G** option specifies group


15. N/A


16. To configure your server to have **time synchronization** with server33.example.com: 
- ensure `chronyd` is installed. Start and enable it 
- edit the chronyd config file /etc/chrony.conf
  - here, comment out the existing "pool" or "server" lines 
  - add the custom server: `server server33.example.com iburst`. Copy the format of the one that was commented out
  - save
- restart the chrond service 
- verify the synchronization `chronyc sources -v`


17. To set up **automount** so that any user who accesses their home directory in */home/ldapuser* will automatically mount the matching directory from *nfsserver:/home/ldapuser/*:
- ensure nfs-utils and autofs are installed with `dnf`
- edit the master config file */etc/auto.master* 
  - here, add the mount point and the secondary file: `/home/ldapuser   /etc/auto.ldapuser`
- create the secondary file and edit it
  - vim /etc/auto.ldapuser
  - here, add the configuration for the wildcard needed for this:
    - `*  -rw  nfsserver:/home/ldapuser/&`
- enable and start the autofs and nfs-utils services
