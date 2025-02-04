
# Using dnf for package management
## Exercise 9-2
Demonstrate useful dnf commands.

### Step 1: List repos

Show list of current repositories the system is using.

```bash
dnf repolist
```

### Step 2: Search with "search"

This will not return a matching result. It's good to explore how different search commands work.

```bash
dnf search seinfo
# Output: 

# Updating Subscription Management repositories.
# Last metadata expiration check: 0:00:32 ago on Mon 04 Nov 2024 09:51:11 PM.
# No matches found.
```

### Step 3: Search with "provides"

The output shows that the setools-console package contains this file.

```bash
dnf provides seinfo
# Output: 

# Updating Subscription Management repositories.
# Last metadata expiration check: 0:02:14 ago on Mon 04 Nov 2024 09:51:11 PM.
# setools-console-4.4.0-4.el9.x86_64 : Policy analysis command-line tools for SELinux
# Repo        : rhel-9-for-x86_64-baseos-rpms
# Matched from:
# Filename    : /usr/bin/seinfo

# setools-console-4.4.0-5.el9.x86_64 : Policy analysis command-line tools for SELinux
# Repo        : rhel-9-for-x86_64-baseos-rpms
# Matched from:
# Filename    : /usr/bin/seinfo

# ...
```

### Step 4: Install the package

Based on the info from the output of the previous command, install the package with the file which is required. 

```bash
dnf install -y setools-console
# Output:

# Updating Subscription Management repositories.
# Last metadata expiration check: 0:06:27 ago on Mon 04 Nov 2024 09:51:11 PM.
# Package setools-console-4.4.1-1.el9.x86_64 is already installed.
# Dependencies resolved.
# ==========================================================================================================================
#  Package                     Architecture       Version                   Repository                                 Size
# ==========================================================================================================================
# Upgrading:
#  python3-setools             x86_64             4.4.4-1.el9               rhel-9-for-x86_64-baseos-rpms             609 k
#  setools-console             x86_64             4.4.4-1.el9               rhel-9-for-x86_64-baseos-rpms              50 k

# Transaction Summary
# ==========================================================================================================================
# Upgrade  2 Packages

# Total download size: 659 k
# Downloading Packages:
# (1/2): setools-console-4.4.4-1.el9.x86_64.rpm                                             9.5 kB/s |  50 kB     00:05    
# (2/2): python3-setools-4.4.4-1.el9.x86_64.rpm                                             113 kB/s | 609 kB     00:05    
# --------------------------------------------------------------------------------------------------------------------------
# Total                                                                                     122 kB/s | 659 kB     00:05     
# Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)                                     2.1 MB/s | 3.6 kB     00:00    
# ...
# Key imported successfully
# Running transaction check
# Transaction check succeeded.
# Running transaction test
# Transaction test succeeded.
# Running transaction
#   Preparing        :                                                                                                  1/1 
#   Upgrading        : python3-setools-4.4.4-1.el9.x86_64                                                               1/4 
#   Upgrading        : setools-console-4.4.4-1.el9.x86_64                                                               2/4 
#   Cleanup          : setools-console-4.4.1-1.el9.x86_64                                                               3/4 
#   Cleanup          : python3-setools-4.4.1-1.el9.x86_64                                                               4/4 
#   Running scriptlet: python3-setools-4.4.1-1.el9.x86_64                                                               4/4 
#   Verifying        : python3-setools-4.4.4-1.el9.x86_64                                                               1/4 
#   Verifying        : python3-setools-4.4.1-1.el9.x86_64                                                               2/4 
#   Verifying        : setools-console-4.4.4-1.el9.x86_64                                                               3/4 
#   Verifying        : setools-console-4.4.1-1.el9.x86_64                                                               4/4 
# Installed products updated.

# Upgraded:
#   python3-setools-4.4.4-1.el9.x86_64                          setools-console-4.4.4-1.el9.x86_64                         

# Complete!

```

### Step 5: Verify the package is installed
Add the GPG check to the end of each file created, then verify the availability of the new repo.

```bash
dnf list setools-console
# Output:

# Updating Subscription Management repositories.
# Last metadata expiration check: 0:01:30 ago on Mon 04 Nov 2024 10:00:32 PM.
# Installed Packages
# setools-console.x86_64                             4.4.4-1.el9                              @rhel-9-for-x86_64-baseos-rpms
```

### Step 5: Remove the package
Add the GPG check to the end of each file created, then verify the availability of the new repo.

```bash
dnf history
# Output:

# ID     | Command line                                                        | Date and time    | Action(s)      | Altered
# --------------------------------------------------------------------------------------------------------------------------
#      2 | install -y setools-console                                          | 2024-11-04 21:57 | Upgrade        |    2  <
#      1 |                                                                     | 2024-10-28 09:24 | Install        | 1744 >E

dnf history undo 2 
# Output: 

# Last metadata expiration check: 0:04:41 ago on Mon 04 Nov 2024 10:00:32 PM.
# Dependencies resolved.
# ================================================================================================================================
#  Package                       Architecture         Version                   Repository                                   Size
# ================================================================================================================================
# Downgrading:
#  python3-setools               x86_64               4.4.1-1.el9               rhel-9-for-x86_64-baseos-rpms               600 k
#  setools-console               x86_64               4.4.1-1.el9               rhel-9-for-x86_64-baseos-rpms                49 k

# Transaction Summary
# ================================================================================================================================
# Downgrade  2 Packages

# Total download size: 649 k
# Is this ok [y/N]: y
# Downloading Packages:
# (1/2): python3-setools-4.4.1-1.el9.x86_64.rpm                                                   114 kB/s | 600 kB     00:05    
# (2/2): setools-console-4.4.1-1.el9.x86_64.rpm                                                   9.0 kB/s |  49 kB     00:05    
# --------------------------------------------------------------------------------------------------------------------------------
# Total                                                                                           120 kB/s | 649 kB     00:05     
# Running transaction check
# Transaction check succeeded.
# Running transaction test
# Transaction test succeeded.
# Running transaction
#   Preparing        :                                                                                                        1/1 
#   Downgrading      : python3-setools-4.4.1-1.el9.x86_64                                                                     1/4 
#   Downgrading      : setools-console-4.4.1-1.el9.x86_64                                                                     2/4 
#   Cleanup          : setools-console-4.4.4-1.el9.x86_64                                                                     3/4 
#   Cleanup          : python3-setools-4.4.4-1.el9.x86_64                                                                     4/4 
#   Running scriptlet: python3-setools-4.4.4-1.el9.x86_64                                                                     4/4 
#   Verifying        : python3-setools-4.4.1-1.el9.x86_64                                                                     1/4 
#   Verifying        : python3-setools-4.4.4-1.el9.x86_64                                                                     2/4 
#   Verifying        : setools-console-4.4.1-1.el9.x86_64                                                                     3/4 
#   Verifying        : setools-console-4.4.4-1.el9.x86_64                                                                     4/4 
# Installed products updated.

# Downgraded:
#   python3-setools-4.4.1-1.el9.x86_64                             setools-console-4.4.1-1.el9.x86_64                            

# Complete!

# Verify that the package is not installed
dnf list setools-console
# Output: 

# Last metadata expiration check: 0:07:09 ago on Mon 04 Nov 2024 10:00:32 PM.
# Available Packages
# setools-console.x86_64                                4.4.4-1.el9                                 rhel-9-for-x86_64-baseos-rpms 
```

Notice the package is **Available** and not **Installed**

---

