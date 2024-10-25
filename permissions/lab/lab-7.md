
# Lab 7

Lab on permissions and groups.

#### 1. Set up a shared group environment with new new directories - marketing and ops. Make the group sales the owner of the directory sales, and make the group account the owner of the directory account.

Start from a root shell. 

```bash
mkdir marketing && mkdir ops
groupadd marketing
groupadd ops
chown :ops ops && chown :marketing marketing
ls -l
#Output - check if the group owners of the directories are correct

# drwxr-xr-x. 2 root marketing 6 Oct 24 20:11 marketing
# drwxr-xr-x. 2 root ops       6 Oct 24 20:11 ops
```

#### 2. Configure the permissions so that the user owner (which must be root) and group owner have full access to the directory. There should be no permissions assigned to the others entity.

```bash
chmod 770 marketing/ && chmod 770 ops/
ls -l
#Output - check if the permissions are set correctly

# drwxrwx---. 2 root marketing 6 Oct 24 20:11 marketing
# drwxrwx---. 2 root ops       6 Oct 24 20:11 ops
```

#### 3. Ensure that all new files in both directories inherit the group owner of their respective directory.

This involves setting the group id (SGID): 

```bash
chmod g+s marketing/ && chmod g+s ops/

#Test if it works by creating new files in both directories and view the file details with ls 

cd marketing
touch newfile
ls -l

#Output: 
# -rw-r--r--. 1 root marketing 0 Oct 24 20:30 newfile

cd ops
touch newfile
ls -l

#Output: 
# -rw-r--r--. 1 root ops 0 Oct 24 20:30 newfile
```
#### 4. Ensure that users are only allowed to remove files of which they are the owner.
This involves setting the sticky bit: 

```bash
chmod +t marketing/ && chmod +t ops/
ls -l
#Output - check if sticky bit is set - T should be at the end of the permissions 

# drwxrws--T. 2 root marketing 21 Oct 24 20:30 marketing
# drwxrws--T. 2 root ops       21 Oct 24 20:30 ops
```

