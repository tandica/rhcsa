# Loading kernel modules with params
## Exercise 16-2


### Step 1: Explore modules with params

Look for the **cdrom** kernel module and notice the dependency **sr_mod** in the output.

```bash
lsmod | grep cdrom
# Output:

# cdrom                  90112  2 isofs,sr_mod
```

Try to remove **cdrom**. Since it's used by the **sr_mod**, it won't be removed.

```bash
modprobe -r cdrom
# Output:

# modprobe: FATAL: Module cdrom is in use.
```

Try removing both **cdrom** and **sr_mod**. This also should not work.

```bash
modprobe -r sr_mod; modprobe -r cdrom
# Output:

# modprobe: FATAL: Module sr_mod is in use.
# modprobe: FATAL: Module cdrom is in use.
```

Unmount the cdrom file system then remove **sr_mod**. This should work. 

```bash
umount /dev/sr0

sudo modprobe -r sr_mod
```

### Step 2: Add a parameter.

Look at the information for **cdrom**. Notice it has a **debug** parameter under *parm:*.

```bash
modinfo cdrom
```

Set the debug parameterto 1. This turns the paramter on.

```bash
modprobe cdrom debug=1
```

Create the .conf file and allow the parameter to be enabled every time the cdrom kernel module loads. 

```bash
sudo vim /etc/modprobe.d/cdrom.conf
```

Add the below line:
`options cdrom debug=1`


---