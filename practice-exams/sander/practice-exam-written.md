# Theoretical Exam

## Write what you think the answer should be for each question

A.

1. review

2. to change the host name, do `hostnamectl set-hostname name`

3. create a logical volume
lv has 3 parts, phycial volume, volume group, logical volume. 
- create pv with pv create and specify the size as 500mb
- create vg with vg create 
- create lv with lv create, specify the name "my_lv" and extent size 8MiB. 
- mount it in /etc/fstab and specify ext4 as the file system. mount it on /data 

4. review, forgot 

5. you can use dnf config-manager file:///repo if it's a local repo

6. Use cron job and specify that the user is bob. Specify that the job should run at midnight every night. 

7. To create a user that is not allowed to login, use `useradd -s user1`. 

8. Check the status and logs of httpd service. Confirm if that port is allowed by the firewall. check httpd config file where that port was defined for any errors. 

9. to change root password:
- reboot and access the grub2 menu. press e to edit 
- at the end of the line that starts with Linux, add `init=/bin/bash`
- ctrl + x to boot with these params
- mount with read write: `mount -o remount,rw /`
- change the pw with passwd
- create a file to relabel the SELinux content `touch /.autorelabel`
- start the server with pid 1 as systemd `exec /usr/lib/systemd/systemd`
- reboot

10. get the best performance profile with tuned get recommended. Then set that value. 

11. to find an rpm package that you don’t know the name of, you can use dnf search. review. 

12. locate all files using the find command, search for "root" in the file name. review, seems wrong 

13. if you get a "nothing appropriate" msg for `man -k user`, you can fix it by updating the man db. 

14. you can create the group, then add the user to it. review 

15. review 

16. review 

17. review 

