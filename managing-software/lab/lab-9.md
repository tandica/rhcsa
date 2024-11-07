
# Lab 9

Lab on managing software with dnf and rpm.

#### 1. Copy some RPM files from the installation disk to the /myrepodirectory. Make this directory a repository and make sure that your server is using this repository.

Log in as root, then create the directory:

```bash
mkdir -p myrepo
```

Find out where the installation is mounted, if it is already mounted: 

```bash
df -h
# Output:

# Filesystem      Size  Used Avail Use% Mounted on
# devtmpfs        4.0M     0  4.0M   0% /dev
# tmpfs           1.8G     0  1.8G   0% /dev/shm
# tmpfs           725M   13M  712M   2% /run
# /dev/nvme0n1p3   71G  8.2G   63G  12% /
# /dev/nvme0n1p1 1014M  292M  723M  29% /boot
# tmpfs           363M  108K  363M   1% /run/user/1000
# /dev/sr0        9.0G  9.0G     0 100% /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64
```

Copy the installation files to /myrepo: 

```bash
cp /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64/BaseOS/Packages/*.rpm myrepo/
```

Make the directory a repository:

```bash
createrepo myrepo
```

Ensure the server is using this repository. Edit the repo config file: 

```bash
vim /etc/yum.repos.d/myrepo.repo
```

Add the following lines in the config file: 

```bash
[myrepo]
name=MyRepo
baseurl=file:///myrepo
enabled=1
gpgcheck=0
```


#### 2. List the repositories currently in use on your server

```bash
dnf repolist
```


#### 3. Search for the package that contains the cache-only DNS name server. Do not install it yet.

```bash
dnf search all dns
```

Found the description which matches the dnsmasq package.


#### 3. Perform an extensive query of the package so that you know before you install it which files it contains, which dependencies it has, and where to find the documentation and configuration.

```bash
# files
rpm -ql dnsmasq

# dependencies
rpm -qR dnsmasq

# documentation
rpm -qd dnsmasq

# config
rpm -qc dnsmasq
```


#### 5. Check whether the RPM package contains any scripts. You may download it, but you may not install it yet; you want to know which scripts are in a package before actually installing it, right?

```bash
dnf download dnsmasq
# Output: 
# dnsmasq-2.85-16.el9_4.x86_64.rpm 

# Use the above output for the next command which shows scripts in the package
rpm -qp --scripts dnsmasq-2.85-16.el9_4.x86_64.rpm 
```


#### 6. Install the package you found in step 3.

```bash
dnf install -y dnsmasq
```


#### 6. Undo the installation.

```bash
dnf history
# Check the id of the command you made for the installation 
# Output: 

# ID     | Command line                                               | Date and time    | Action(s)      | Altered
# -----------------------------------------------------------------------------------------------------------------
#      9 | install -y dnsmasq                                         | 2024-11-06 22:54 | Upgrade        |    1   

dnf history undo 9
```

---
