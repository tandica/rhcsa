# Practice Exam 1

### 2. Create user student with password password, and user root with password password.

Root user already has that as a password. As the root user, add student user:

```bash
useradd student

passwd student 
```

### 3. Configure your system to automatically mount the ISO of the installation disk on the directory /repo. Configure your system to remove this loop-mounted ISO as the only repository that is used for installation. Do not register your system with subscription-manager, and remove all references to external repositories that may already exist.

The question is asking to automatically mount the installation ISO to /repo at boot. This ISO should be the only repo used for package installation. 

Create the directory /repo.

```bash
mkdir /repo
```

The installation of the ISO disk is at */dev/sr0*. Automatically mount it using */etc/fstab* file. First, test it with the `mount` command. Good to test to see if there are any errors.

```bash
# temporarily mounts the /dev/sr0 directory onto /repo
mount /dev/sr0 /repo
```

Create a local repo file in */etc/yum.repos.d*

```bash
vim iso-local.repo
```

In the file, add the title in square brackets, name, baseurl, enabled, and gpgcheck:

```vim
[iso-local]
name=iso-local
baseurl=file:///repo
enabled=1
gpgcheck=0
```
The baseurl should point to the local mount point. 

Mount the file in */etc/fstab*:

```bash
vim /etc/fstab
```

Add this: `/dev/sr0		/repo			iso9660	ro,auto		0 0`

`iso9960` is used to specify the file system as an ISO.

`ro` means read only. 

`auto`  means automatically mount. as per the question requirements.

Test with `mount -a`.

Verify that the files in the ISO are now in /repo:

```bash
ls -l /repo
```

You can `reboot` to see if there are any errors, just to be safe, and double check the /repo directory to ensure the mount is persistent.


### 4. Reboot your server. Assume that you don’t know the root password, and use the appropriate mode to enter a root shell that doesn’t require a password. Set the root password to "mypassword".

- Reboot and press ESC to access the GRUB2 menu. Type `e` to edit.
- Edit the line that defines the intramfs/the line that starts with linux and add `init=/bin/bash`
- Start with ctrl + X
- Once the prompt comes up, remount the root file system to read/write: `mount -o remount,rw /`
- Change the password with `passwd`
- Relabel all files (SELinux): `touch /.autorelabel`
- Start the system with Systemd as PID 1: `exec /usr/lib/systemd/systemd`
- Reboot
- Once the server reboots, login with the new password to test


### 5. Set default values for new users. Set the default password validity to 90 days, and set the first UID that is used for new users to 2000.


