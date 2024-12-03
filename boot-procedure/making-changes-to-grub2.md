# Making modifications to GRUB 2 
## Exercise 17-2


### Step 1: Remove **rhgb** and **quiet** options from the GRUB file

The options **rhgb** and **quiet** tell the kernel to hide the output while booting, but these messages may be helpful for us to see what is going on.

```bash
su - root 

vim /etc/default/grub
```


### Step 2: Set the GRUB_TIMEOUT to 10 seconds in the same file.

Modify the below parameter to this:
`GRUB_TIMEOUT=10`

Save and exit the file.


### Step 3: Write the changes to GRUB 2.

```bash
grub2-mkconfig > /boot/grub2/grub
# Output:

# Generating grub configuration file ...
# File descriptor 3 (pipe:[76230]) leaked on vgs invocation. Parent PID 13598: grub2-probe
# File descriptor 9 (pipe:[79020]) leaked on vgs invocation. Parent PID 13598: grub2-probe
# File descriptor 3 (pipe:[76230]) leaked on vgs invocation. Parent PID 13598: grub2-probe
# File descriptor 9 (pipe:[79020]) leaked on vgs invocation. Parent PID 13598: grub2-probe
# Adding boot menu entry for UEFI Firmware Settings ...
# done
```

---