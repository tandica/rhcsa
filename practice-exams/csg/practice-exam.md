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

