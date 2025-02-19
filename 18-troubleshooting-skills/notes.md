# Chapter 18: Essential Troubleshooting Skills

Boot Procedure Steps:

1. **Performing POST**
- machine is pwered on
- Power-On Selt-Test is executed (POST)
- hardware required to start the sytem is initialized

2. **Select the bootable device**
- from either the UEFI bootloader or BIOS, a bootable device is located

3. **Loading the bootloader**
- a bootloader is located, usually GRUB 2 on RHEL

4. **Loading the kernel**
- to load linux, the kernel is loaded along with initramfs
  - *initramfs*:
    - has kernel modules for all hardware requireed to boot 
    - has initial scripts requires to proceed to the next booting stage
    - on RHEL, it has a complete operational system which can be used for troubleshooting

5. **Starting /sbin/init**
- Once kernel is loaded into memory, the first process (/sbin/init) is loaded, but still from the intramfs
- **systemd-udevd** daemon is loaded to take care of further hardware initialization
- everything is happening from the inramfs image

6. **Processing initrd.target**
- systemd process executes all units from the *initrd.target*, which prepares a minimal operating environment
- root file system on disk is mounted on /sysroot
- enough is loaded to pass the system installation that was written to the hard drive

7. **Switching to the root file system**
- switches to the root file system on disk
- can load Systemd process from disk

8. **Running the default target**
- SYstemd looks for the default target to execute and runs all of its units 
- login screen and auth
- even though you see the login screen, it doesn't mean the server is fully operational
  - services can still be loaded in the background

<br />

To access thee boot prompt, look for the GRUB 2 menu that briefly shows up during the server boot. 
- Type **e** to enter a mode where you can edit commands or pass boot options to a starting kernel
- Type **c** to enter a full GRUB command prompt
- After entering boot options, use **crtl + x** to start the kernel with these options
  - These changes are not persistent
  - If you want persistent changes, modify */etc/default/grub* config file and write the changes with `grub2-mkconfig > /boot/grub2/grub.cfg`

**rd.break**
- stops the boot procedure in the intramfs stage
- system will be in intrmfs stage of botting, which means the root file system isn't mounted on / yet
- requires root password

`init=/bin/sh` or `init=/bin/bash`
- specifies a shell should be started immediately after loading a kernel and intrd
- provides earliest possible access to a running system'- only root file system is mounted so far, no password

`systemd.unit=emergency.target
- enters a mode that loads the minimum number of systemd units
- requires root password

`systemctl list-units` displays the unit files that have been loaded.

When using a rescue disk, the first "choice" should be "Rescue Red Hat Enterprise Linux System".
- "Run amemory test" if you encounter memory errors
- "Boot from a local drive" if you can't boot from GRUB on the hard disk
  - offers a bootloader that tries to install from the machine's hard drive

`chroot /mnt/sysimage` makes the contents of this directory your working directory. Ensures all path references to config files are correct. 

How to install GRUB 2 using a rescue disk:
1. Ensure you haev the contents of /mnt/sysimage using `chroot /mnt/sysimage`
2. Install GRUB is==using `grub2install /dev/sda`.

How to repair the initramfs:
- `dracut` without arguments creates a new initramfs for the currently loaded kernel
- To create the initramfs, use `dracut --force`

File system issues
- if there's an error with */etc/fstab* while booting, it will ask for the root password
- Use `journalctl -xb` to look for relevant msgs relating to boot precedure
- If problem is related to file system, type `mount -o remount,rw /` to ensure the root file system is mounted with read/write permissions and analyze what's wrong with */etc/fstab*

`exec /usr/lib/systemd/systemd` changes the current PID1 to be Systemd.

#### Boot phase config & troubleshoot

1. POST
- hardware config (f2, esc, f10)
- fix by replacing hardware

2. Select bootable device 
- BIOS/UEFI config or boot menu
- fix by repkacing hardware or use rescue system

3. Loading the boot loader 
- configure with `grub2-install` and edit */etc/default/grub*
- fix by using GRUB 2 boot prompt, edit */etc/default/grub* and save changes with `grub2-mkconfig > /boot/grub2/grub.conf`

4. Loading the kernel
- configure by editing GRUB and */etc/dracut.conf*
- fix the same as above

5. Start /sbin/init
- config - compiled into initramfs
- fix by using the `init=` kernel boot argument and `rd.break` kernel boot argument

6. Processing initrd.target
- config - compiled into initramfs
- fix by using `dracut` to create a new initramfs

7. Switch to root file system
- configure by editing */etc/fstab*
- fix by applying (mount) changes to */etc/fstab*

8. Running the default target
- configure by using `systemctl set-default`
- fix by starting the rescue target as a kernel boot argument 

#### How to reset the root password 

1. Type **e** in the GRUB 2 menu on system boot.

2. Add `init=/bin/bash` to the end of the line that loads the kernel and boot with **ctrl + x**. 

3. When the root shell is open, type `mount -o remount,rw /` to get read/write access to the root file system. 

4. Change the password with `passwd`. 

5. Type `touch /.autorelabel` to ensure the SELinux security labels are set correctly. 

6. Start the system "normally" with `exec /usr/lib/systemd/systemd`. This makes Systemd the PID 1, which allows you to reboot. Otherwise, the PID 1 is set to /bin/bash and you can't run the reboot command in this. 

7. Use `reboot` and verify you can log in as root. 


<br />

### Do you already know? Questions

1. In the boot procedure, GRUB 2 bootloader is first, then kernel & intramfs, then Systemd.

2. **ctrl + x** allows you to start the kernel with an argument in the GRUB 2 boot prompt.

3. /etc/dracut.conf shows options for intramfs and manages its file system.

4. To reset the root pw, use either of these kernel arguments: **init=/bin/bash** or **init=/bin/sh**.

5. Remove **quiet** and **rhgb** from the GRUB 2 boot prompt to see messages about what's happening in the boot process.

6. `systemd.unit=emergency.target` loads only root shell, so few services are loaded.

7. A scenario which can only be resolved by using a rescue disk is never getting to the GRUB 2 boot prompt.

8. If you're in troubleshooting mode and disk access is read-only, you should do `mount -o remount,rw /` to remount the root (/) file system in read/write mode.

9. If there's only a blinking cursor and no GRUB 2 menu yet, the first step is to go to a rescue disk and try the *boot from local disk option*.

10. After resetting the root password, restart the system normally with `exec /usr/lib/systemd/systemd`


### Review Questions

1. To enter the GRUB boot menu editor mode, type **e**.

2. If during a boot procedure, its not completed and it asks for the root password, there is an error in */etc/fstab*.

3. If you want to enter troubleshooting mode, but don't know the root pw, add `init=/bin/bash` to the line that loads the kernel.

4. If you start your server and nothing happens, you just see a blinking cursorm the first step is to boot from a rescue system.

5. To see which units are available in a troubleshooting environment, use `systemctl list-units`.

6. To start your system normally after changing the root pw from init=/bin/bash, make systemd be PID1 with `exec /usr/lib/systemd/systemd`.

7. To ensure SELinux security labels are set correctly after resetting tje root pw, type `touch /.autorelabel` to create this file in the root directory.

8. To make the root file system writable again, use `mount -o remount,rw /`.

9. To save changes to the GRUB 2 bottloader, use `grub2-mkconfig > /boot/grub2/grub.cfg`.

10. To enter the most minimal troubleshooting made on a system where you don't know the root pw, use `systemd.unit=emergency.target`.
