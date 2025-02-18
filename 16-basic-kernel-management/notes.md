# Chapter 16: Basic Kernel Management

**kernel**
- layer between the user who works ina  shell environment and the hardware in the computer
- manages input/output instructions from software and translates them into the processing instructions that are executed by the CPU and other hardware in the computer
- handles essential OS tasks

kernel threads are recognized with the `ps aux` command. The thread names are in between square brackets []. 

To ensure hardware can be used, the linux kernel uses **drivers**. Drivers are loaded as kernel modules. 

`dsmeg`
- shows recent kernel log msgs
- the msgs are the contents of the kernel ring buffer, an area of memory where the kernel keeps recent log messages
- same as `journalctl --dsmeg` and `journalctl -k`
  - these 2 commands use clock time instead of time relative to the start of the kernel

**/proc** 
- file system that is an interface to the linux kernel 
- has files with detailed status info about what is happening on the server
- performance-related commands get info from here

`uname`
- gives different info about ther OS
- `uname -a`: overview of all relevant parameters
- `uname -r`: which kernel version is currently used

Modular kernel
- small core kernel and driver support through modules
- modules are used to load drivers that allow proper communications with hardware devices

`udevadm monitor` lists all events that are processed while activating new hardware devices. If you plug in a USB, you can see what's happening.

`lsmod` lists currently loaded kernel modules.

`modinfo` displays info about kernel modules.

`modprobe` loads kernel modules, including all of their dependencies.

`modprobe -r` unloads kernel module, considering kernel dependencies.

`lspci -k` lists all kernel modules that are used for PCI dedvices detected.

`dnf upgrade kernel` installs new version of kernel. `dnf install kernel` does the same thing.

<br />

### Do you already know? Questions

1. A tainted kernel is caused by drivers that are not open source. They impact the stability of a linux OS.

2. `dsmeg` shows kernel events since booting. `journalctl -k` shows the smae thing.

3. `uname -r` shows the current kernel version. `uname -v` provides info about the hardware on your computer.

4. `cat /etc/redhat-release` shows info about the current version of RHEL being used. 

5. `systemd-udevd` helps the kernel initialize hardware properly.

6. Default rules for initializing new hardware devices are found in */usr/lib/udev/rules.d*.

7. `modprobe -r` unloads a kernel module from memory.

8. `lspci -k` shows you if the appropriate kernel modules have been loaded for hardware. 

9. */etc/modprobe.d* is where you specify a kernl module parameetr to make it persistent.

10. To update a kernel, use `dnf upgrade kernel`, `dnf update kernel` or `dnf install kernel`. Kernels are installed, not updated. You don't have to do any other steps. The new kernel version is installed beside the old version.


### Review Questions

1. `uname -r` shows the current version of the kernel.

2. */etc/redhat-release* shows info about the current version of RHEL installed. 

3. `lsmod` shows a list of currently loaded kernel modules. 

4. `modinfo modulename` allows you to find kernel module parameters.

5. To unload a kernel module, use `modprobe -r modulename`.

6. If you get an error while trying to unload a kernel module, you can use `lsmod` to look for dependencies of the module, then try to unload those first. 

7. Use `modinfo` to find out which kernel module parameters are supported.

8. To specify kernel module parameters that should be used persistently, create a file in */etc/modprobe.d/filename* and add the parameters with an options statement.

9. To add the parameter *debug* to the cdrom module, add the line `options cdrom debug=``, assuming you want to set the debug value to 1. 

10. To install a new version of the kernel, you can use `dnf upgrade kernel` or `dnf install kernel`.
