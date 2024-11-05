
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

### Step 5: Verify the newly created repository
Add the GPG check to the end of each file created, then verify the availability of the new repo.

```bash
ls /etc/yum.repos.d/.
# Output:

# redhat.repo  repo_AppStream.repo  repo_BaseOS.repo

vim /etc/yum.repos.d/repo_AppStream.repo 
```
In the vim editor, add this line to the end of the file:

```bash
gpgcheck=0
```
This line means that the repo does not have to perform an integrity check for security purposes.

Do the same for /etc/yum.repos.d/repo_BaseOS.repo. 

Check the availability of the new repo:
```bash
dnf repolist

# Output:

# repo id                          repo name
# repo_AppStream                   created by dnf config-manager from file:///repo/AppStream
# repo_BaseOS                      created by dnf config-manager from file:///repo/BaseOS
# rhel-9-for-x86_64-appstream-rpms Red Hat Enterprise Linux 9 for x86_64 - AppStream (RPMs)
# rhel-9-for-x86_64-baseos-rpms    Red Hat Enterprise Linux 9 for x86_64 - BaseOS (RPMs)
```

---

