# How to reset root password

#### 1. Go to the GRUB2 menu and type `e` to edit

#### 2. Go to the line that starts with "linux" and go all the way to the end of the line. Type `init=/bin/bash`.

#### 3. Boot with "ctrl + x"

#### 4. Remount the root partition as read/write with `mount -o remount,rw /`

#### 5. Change the password for Root using `passwd`. 

#### 6. Ensure the SELinux context types are correct by creating a autorelabel file with `touch /.autorelabel`.

#### 7. Start the system with Systemd as PID (process id 1): `exec /sbin/init`

#### 8. `reboot`



<br>

> You can also change the "ro" in the grub menu to "rw" to avoid step 4: remounting the root partition as read/write.
