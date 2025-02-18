# Chapter 17: Managing and Understanding the Boot Procedure

**systemd target** - a group of units that belong together

**isolatable targets** are targets that can be isolated. They contain everything a system needs to boot or change its current state.

4 targets can be used while booting: 

1. **emergency.target**
- only a minimal number of units are started, enough to fix your system if something is seriously wrong
- very minimal, as some important units are not started

2. **multi-user.target**
- often used as the default target a system starts in
- starts everything that is needed for full system functionality and is commonly used on servers

3. **graphical.target**
- commonly used
- starts all units needed for full functionality, as well as a graphical interface

4. **rescue.target**
- starts all units that are requires to get a full functional, operational linux system
- does not start non-essentail services

<br />

Working with units involve 3 common tasks:
- adding units to be automatically started
- setting a default target
- running a non-default target to enter troubleshooting mode

Targets have 2 parts to them:
- target unit file
- "Wants" directory, which contains references to all unit files that need to be loaded when entering a specific target

Some targets, like multi-user.target and graphical.target, define a specific state the system needs to enter, while others just group a bunch of units together.

**Systemd Wants** define which units Systemd wants when starting a specific target.

**Wants**
- created when systemd units are enabled using `systemctl enable`
- happens by creating a symbolic link in the */etc/systemd/system*
  - this directory has many folders for each target with its symbolic links

`systemctl --type=target` lists current active targets.

`systemctl -t target --all` lists all targets that exist on your machine, even inactive.

`system isolate target.name` changes the state of your computer to the specified target.

`systemctl get-default` shows the current default target.

`systemctl set-default` sets the desired default target.

** **On the exam, go through the queestions first and enable the services needed at once so they start automatically when you reboot.**

** **Also, remove the options rhgb and quiet from */etc/default/grub* because it hides all messages/outputs while booting. It could have useful messages that you need to see during the boot process.**

Grub2 boot loader: configured to load a linux kernel and the intramfs.

**kernel**: allows users to interact with the hardware that is installed in the server.

**intramfs**
- contains drivers needed to start the server
- mini file system that is mounted during boot
  - it has kernel modules needed for the rest of the boot process

Grub 2 config 
- file to be modified: */etc/default/grub*
  - most important line is **GRUB_CMDLINE_LINUX** which defines how the kernel should be started
  - when you make changes to this config, you need to regenerate the main config file. These files shouldn't be edited becauyse they get regenerated.
- main config files:
  - for BIOS: */boot/grub2/grub.cfg*
  - for UEFI: */boot/efi/EFI/redhat/grub.cfg*
  - you must regenerate the above files after making changes to */etc/default/grub*
  - only regenerate the one that your system uses
  - regenerate w/ `grub2-mkconfig`

`grub2-mkconfig > /config/path` regenerates config file after changing */etc/default/grub*

**GRUB_TIMEOUT** - the amount of time your server waits for you to access the GRUB2 boot menu before it continues to boot automatically.

`man 7 bootparam` shows all boot parameters for starting the kernel.

<br />

### Do you already know? Questions

1. `systemctl enable` is the most efficient way to define a system **want**.

2. The **multi-user.target** is the normal target for servers to start on.

3. **rescue.target**, **multi-user.target** and **graphical.target** are all Systemd targets.

4. Define which target a unit should be started in, in the **[Install]** section of the unit file.

5. For targets to be isolated, the statement **AllowIsolate** should be in the target unit file. 

6. To switch targets on a running system, use `systemctl isolate ____.target`.

7. multi-user.target corresponds to runlevel 3 in the legacy System V environment.

8. Changes to the GRUB 2 config need to be made in */etc/default/grub*.

9. `grub2-mkconfig >/boot/grub2/grub.cfg` writes the changes made to */etc/default/grub* by regenrating the main config file.

10. On a UEFI system the GRUB 2 main config file is at */boot/efi/EFI/redhat/grub.cfg*.


### Review Questions

1. A **unit** is something started by Systemd. Different types of units include services, mounts, sockets adn more. 

2. `systemctl mask` ensures a target is no longer eligible for an automatic start on system boot.

3. To apply common changes to GRUB2, modify */etc/default/grub2*.

4. `systemctl --type=service` shows all service units that are active.

5.  To create a **Want** for a service, use `systemctl enable`.

6. `systemctl isolate rescue.target` switches the current operational target to rescue.target.

7. If a target cannot be isolated, it's probably not isolatable, meaning it can't run independently. There are 2 types of targets: those which can be isolated and those which can't.

8. `systemctl list-dependencies --reverse` shows which other units have dependencies to a Systemd service. *Ex:* `systemctl list-dependencies --reverse network.target`. 

9. To apply changes to GRUB 2, modify */etc/default/grub* then regenerate the main config file with `grub2mkconfig > /boot/grub2/grub.cfg`.

10. `grub2-mkconfig > /path/to/config` applies the changes made in */etc/default/grub* to the main grub config file. 

