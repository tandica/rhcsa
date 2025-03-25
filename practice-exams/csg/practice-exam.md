# CSG Practice Exam

### 1. Interrupt the boot process and reset the root password. CHange it to "password" to gain access to the system.

1. Go to the GRUB2 menu and type `e` to edit

2. Go to the line that starts with "linux" and go all the way to the end of the line. Type `init=/bin/bash`.

3. Boot with "ctrl + x"

4. Remount the root partition as read/write with `mount -o remount,rw /`

5. Change the password for Root using `passwd`. 

6. Ensure the SELinux context types are correct by creating a autorelabel file with `touch /.autorelabel`.

7. Start the system with Systemd as PID (process id 1): `exec /usr/lib/systemd/systemd`

8. `reboot`

### 2. Add BaseOS and AppStream repos to the server.

`dnf config-manager --add-repo=https://link-to-baseos`

`dnf config-manager --add-repo=https://link-to-appstream`

You can run `dnf update` to ensure that everything is running.

### 3. Set the system time to your nearest timeone and ensure NTP sync is configured.

Get your timezone:

```bash
timedatectl list-timezones
```
Set the timezone:
```bash
timedatectl set-timezone America/Toronto
```

Configure NTP (turn it on):
```bash
timedatectl set-ntp 1
```

For NTP, ensure the **chronyd** service is installed. This service gets the time from the internet by default.

```bash
dnf install -y chronyd

systemctl enable --now chronyd

systemctl status chronyd
```

### 4. Add the following secondary IP addresses statically to your current running interface. Do this in a way that doesn't compromise your existing settings: 
#### a. IPV$ - 10.0.0.5/24
#### b. IPV6 - fd01::100/64

Check the active network interfaces: `ifconfig`. The active interface is the one you want to change. The one which was chosen had 7.9 MiB vs the other one which had 9.2KiB. Look for the name of it (eth1).

Modify the connection:
```bash
nmcli connection modify "System eth1" +ipv4.address 10.0.0.5/24
```

Reload the connection:
```bash
nmcli connection reload
```

Show the connection to confirm the IP is added: 
```bash
nmcli connection show "System eth1
```


Do the same with the other IP: `` 
```bash
nmcli connection modify "System eth1 ipv6.method manual ipv6.addresses fd01::100/64
```

Reload the connection again and show it to confirm the address was added.


### 5. Enable packet forwarding on System1. This hsould persist after reboot.

This has to do with the */etc/sysctl.conf* file. 

Edit that file and add the line `net.ipv4.ip_forward=1`

Check the status of forwarding in this file path: */proc/sys/net/ipv4/ip_forward*:
`cat /proc/sys/net/ipv4/ip_forward`

Reboot.

Check the same file and see that the output is now **1**.

```bash
cat /proc/sys/net/ipv4/ip_forward
# Output:
# 1
```

### 6. System1 should reboot into the multiuser target by default and boot messages should be present.

To set that target:

```bash
systemctl set-default=multi-user.target
```

Check that the target is set:
```bash
systemctl get-default
```

To ensure boot messages are present, edit the the */etc/default/grub* file. Remove **rhgb** and **quiet**. 

```bash
vim /etc/default/grub
```

Write the changes to the main config file in */boot/grub2/grub.cfg*:

```bash
grub2-mkconfig -o /boot/grub2/grub.cfg
```

Reboot to see the changes.


### 7. Create a new 2GB volume group named "vgprac".

For this, I'm going to add a new hard disk before starting the VM.

After starting, run `lsblk` and look that the disk (nvme0n2) is created properly.

```bash
lsblk
# Output: 

# NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
# sr0            11:0    1  8.9G  0 rom  /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
# nvme0n1       259:0    0   35G  0 disk 
# ├─nvme0n1p1   259:1    0    1G  0 part /boot
# └─nvme0n1p2   259:2    0   34G  0 part 
#   ├─rhel-root 253:0    0 30.5G  0 lvm  /
#   └─rhel-swap 253:1    0  3.5G  0 lvm  [SWAP]
# nvme0n2       259:3    0    4G  0 disk 
```

Go into fdisk with the created hard disk and create a partition. Make sure to specify the desired size of 2GB in the "Last Sector" prompt.

```bash
fdisk /dev/nvme0n2

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-8388607, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-8388607, default 8388607): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

Confirm it was created properly.

```bash
lsblk
# Output: 

# nvme0n2       259:3    0    4G  0 disk 
# └─nvme0n2p1   259:4    0    2G  0 part
```

A physical volume should be created before the volume group.

Create one with the new partition:

```bash
pvcreate /dev/nvme0n2p1
```

Create the volume group with the specified name:

```bash
vgcreate vgprac /dev/nvme0n2p1
```

List volume groups to confirm it was created:

```bash
vgs
# Output:

  # VG     #PV #LV #SN Attr   VSize   VFree 
  # rhel     1   2   0 wz--n- <34.00g     0 
  # vgprac   1   0   0 wz--n-  <2.00g <2.00g
```

### 8. Create a 500mb logical volume names "lvprac" inside the "vgprac" volume group.

Create the LV:

```bash
lvcreate -L 500M -n lvprac vgprac
```

Confirm the creation of the LV:

```bash
lvs
# Output:
  # LV     VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  # root   rhel   -wi-ao---- <30.50g                                                    
  # swap   rhel   -wi-ao----   3.50g                                                    
  # lvprac vgprac -wi-a----- 500.00m    
```

### 9. The "lvprac" logical volume should be formatted with the XFS filesystem and mounted persistently on the /mnt/lvprac directory. 

Create file system on the lvprac logical volume. Use the path with the volume group name: 
```bash
mkfs.xfs /dev/vgprac/lvprac
```

Check that it was successful:
```bash
lsblk -f
# Output:
  # └─vgprac-lvprac
  #    xfs                e883167d-9775-471b-b6c6-3476eaec17c7  
```

Create the mount folder:
```bash
mkdir /mnt/lvprac
```

Edit the */etc/fstab* file and add the following:
```bash
/dev/vgprac/lvprac      /mnt/lvprac             xfs     defaults        0 0
```

Check if there are any issues:
```bash
mount -a
# Output:

# mount: (hint) your fstab has been modified, but systemd still uses
#        the old version; use 'systemctl daemon-reload' to reload.
```

Reload the daemon as the message suggests and verify the mount:
```bash
systemctl daemon-reload

df -h
# Output:

# /dev/mapper/vgprac-lvprac  436M   29M  408M   7% /mnt/lvprac
```

### 10. Extend the XFS filesystem on "lvprac" by 500MB.

**-r** option resizes the filesystem.
Add the plus (+) to increase the size by a specific amount!

```bash
lvextend -r -L +500M /dev/vgprac/lvprac
# Output:

# mount: (hint) your fstab has been modified, but systemd still uses
#        the old version; use 'systemctl daemon-reload' to reload.
```

### 12. Configure a basic web server that displays a message once connected. Ensure firewall is configured for the httpd service. 

1. install httpd server. enable and start it.
2. create a directory and index.html file 
3. add the file to the httpd service config file
4. ensure firewall is allowed on that port (80) and that httpd is added as a service
5. check page 

Install httpd service, check the status, enable and start if needed:
```bash
dnf -y installl httpd

systemctl status httpd

systemctl enable httpd --now

systemctl status httpd
```

Create and add a message in the file path */var/www/html*:
```bash
vim /var/www/html/index.html
# Message added:
# "Hello from ym web server!"

cat /var/www/html/index.html
# Output:
# Hello from my web server!
```

Configure the firewall. Add the httpd service to the active zone:
```bash
firewall-cmd --add-service=http --permanent

firewall-cmd --add-service=https --permanent

firewall-cmd --reload 

# Verify that the services have been added
firewall-cmd --list-all
```

Check the output:
```bash
curl http://localhost
# Output:

# Hello from my web server!
```

### 13. Find all files that are larger than 5MB in the /etc directory and copy them to /find/largefiles.

Create that directory.
```bash
mkdir -p /find/largefiles
```

Use the find command:
```bash
find /etc/ -size +5M -exec cp {} /find/largefiles/ \;
```

`-size` specifies the size of the files you want to find.

`-exec` allows you to run a command directly on those files which are found.

**{}** refers to the files that are found.

**\;** specifies that the command is closed and done.

Verify the files were copied with `ls -l /find/largefiles`.

### 14. Write a script named awesome.sh in the root directory.
#### a. if "me" is given as an argument, the script should output "Yes, i'm awesome."
#### b. if "them" is given as an arugment, the script should output "Okay, they are awesome"
#### c. if the arguemnt is empty or anything else is given, the script should output "What do you want?"


