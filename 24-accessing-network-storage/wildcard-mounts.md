# Configuring a wildcard mount
## Exercise 24-4

Wildcards can be used to apply the same export options to all items in a directory. They allow you to use specific pattern matching to include multiple directories without having to specify them one by one.

### Step 1: Create a wildcard mount.

Log in to server1.

```bash
ssh root@server1
```

Edit the *autofs* master config file. 

```bash
vim etc/auto.master
```

Include the below to mount the /users directory and the secondary file:

```
/users       /etc/auto.users
```

Create the secondary file.

```bash
vim etc/auto.users
```

Put the necessary config info inside that file: 

```
*      -rw      server2:/users/&
```

> The `*` indicates a wildcard that matches any directory name. The mount options include read/write permissions (`-rw`). `server2:/users/&` specifies the NFS server and path that should be "exported" or accessible in server1. The `&` is a placeholder for a specific directory that wilol be accessed.

Restart the *autofs* service.

```bash
systemctl restart autofs
```

Get access to the /user/user1 directory on server2 through the mount you just created in server1.

```bash
cd /user/user1
```


---