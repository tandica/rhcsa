Source: https://github.com/aggressiveHiker/rhcsa9/blob/main/exam_prep/ordered_task_list.md 

### 1. Break into server2 and set the password as password. Set the target as multi-user and make sure it boots into that automatically. Reboot to confirm.

- reboot and access the grub2 menu
- edit the line that starts with linux and add `init=/bin/bash`
- ctrl + x to boot
- once youre in the server, mount the root file system: `mount -o remount,rw /`
- change the password with `passwd`
- ensure selinux labels are set correctly `touch /.autorelabel`
- for the second requirement of multi-user target, do **`systemctl set-default multi-user.target`**
- start the system with Systemd as PID 1: `exec /usr/lib/systemd/systemd`
- reboot 



