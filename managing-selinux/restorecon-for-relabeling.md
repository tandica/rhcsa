# Using *restorecon* to relabel files
## Exercise 22-4


### Step 1: Relabel a file with *restorecon*.

Check the context settings of the **/etc/hosts** file

```bash
ls -Z /etc/hosts
# Output

# system_u:object_r:net_conf_t:s0 /etc/hosts
```

From the output, you can see that the context type is `net_conf_t`.

> `ls -Z` is used to display SELinux contexts for files and directories.


Copy the file to the home directory. This will set the context type label to `admin_home_t`, since its considered a new file in the home directory.

```bash
cp /etc/hosts ~

ls -Z ~/hosts
# Output

# unconfined_u:object_r:admin_home_t:s0 /root/hosts
```

Move this newly created file to the **/etc** folder and confirm you want to overwrite the existing version.

```bash
mv ~/hosts /etc
```

Check the context type label of the file you moved. 

```bash
ls -Z /etc/hosts
# Output

# unconfined_u:object_r:admin_home_t:s0 /root/hosts
```

In the output, you can see that it's still set to `admin_home_t`. Apply the correct context type label.

```bash
restorecon -v /etc/hosts
# Output

# Relabeled /etc/hosts from unconfined_u:object_r:admin_home_t:s0 to unconfined_u:object_r:net_conf_t:s0
```


---