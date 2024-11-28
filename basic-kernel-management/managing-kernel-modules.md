# Managing kernel modules from the command line
## Exercise 16-1


### Step 1: Show all kernel modules currently loaded. 

Start from a root shell. 

```bash
lsmod | less
# Output:

# Module                  Size  Used by
# tls                   159744  0
# uinput                 24576  1
# nls_utf8               12288  1
# ...
```

### Step 2: Load the *vfat* kernel module.

```bash
modprobe vfat
```

**2.1. Verify the module is loaded**

```bash
lsmod | grep vfat
# Output:

# vfat                   16384  0
# fat                   102400  1 vfat
```

**2.2. Get info about the *vfat* kernel module**

```bash
modinfo vfat
# Output:

# filename:       /lib/modules/5.14.0-503.14.1.el9_5.x86_64/kernel/fs/fat/vfat.ko.xz
# author:         Gordon Chaffee
# description:    VFAT filesystem support
```

**2.3. Unload the *vfat* kernel module**

```bash
modprobe -r vfat
```


### Step 3: Try to unload the xfs kernel module

```bash
modprobe -r xfs
# Output:

# modprobe: FATAL: Module xfs is in use.
```

Notice that there is an error, since you cannot remove kernel modules which are in use.

---