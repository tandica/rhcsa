
# Create your own repository
## Exercise 9-1
How to create your own repo in linux.

### Step 1: Create repo directory

```bash
su - root
mkdir /repo
```

### Step 2: Update /etc/fstab config file 

```bash
vim /etc/fstab
```

In vim editor, add the following line to the end of the file:

```bash
/dev/sr0 /repo iso9660 defaults 0 0
```


### Step 3: Mount the optional device 

```bash
mount -a 
mount | grep sr0
# Output: 

# /dev/sr0 on /run/media/tandi/RHEL-9-2-0-BaseOS-x86_64 type iso9660 (ro,nosuid,nodev,relatime,nojoliet,check=s,map=n,blocksize=2048,uid=1000,gid=1000,dmode=500,fmode=400,uhelper=udisks2)

```

### Step 4: Add the BaseOS and AppStream repos

These repos are needed to provide access to base packages and application streams, respectively. We need to add these 2 files to /etc/yum.repos.d. Run the following commands:  

```bash
dnf config-manager --add-repo=file:///repo/BaseOS
# Output: Adding repo from: file:///repo/BaseOS
dnf config-manager --add-repo=file:///repo/AppStream
# Output: Adding repo from: file:///repo/AppStream
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

