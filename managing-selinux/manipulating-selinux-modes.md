# Manipulating SELinux Modes
## Exercise 22-1


### Step 1: Set SELinux in different modes.

Log into the terminal as a root user and check the current SELinux mode.

```bash
su - root 

getenforce
# Output:

# Enforcing
```

Set the SELinux mode to *permissive* and check that it changed.

```bash
setenforce 0

getenforce 
# Output:

# Permissive
```

Set it back to *enforcing* mode and check that it is set properly.

```bash
setenforce 1

getenforce 
# Output:

# Enforcing
```


### Step 2: Check the status of SELinux.

```bash
sestatus
# Output:

# SELinux status:                 enabled
# SELinuxfs mount:                /sys/fs/selinux
# SELinux root directory:         /etc/selinux
# Loaded policy name:             targeted
# Current mode:                   enforcing
# Mode from config file:          enforcing
# Policy MLS status:              enabled
# Policy deny_unknown status:     allowed
# Memory protection checking:     actual (secure)
# Max kernel policy version:      33
```


---