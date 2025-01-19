# Bind-mounting in rootless containers
## Exercise 26-8


### Step 1: Bind-mounting in rootless containers.

In a non-root shell, search *mariadb* for *quay* images which are optimized for RHEL environments and rootless in nature.

```bash
podman search mariadb | grep quay
```

I didn't get any results so I went to quay.io and searched for mariadb. I am using mariadb-105 from the fedora repo.  

```bash
podman run -d --name mydb2 -e MYSQL_ROOT_PASSWORD=pass quay.io/fedora/mariadb-105
# Output: 

# Trying to pull quay.io/fedora/mariadb-105:latest...
# Getting image source signatures
# Copying blob 976372706889 done   | 
# Copying blob c1266253c0b6 done   | 
# Copying blob 95fe7b64e419 done   | 
# Copying config 8a9a2c3ac8 done   | 
# Writing manifest to image destination
# 1d0fef2cb4700865fbf58b610d826353edaf394fd62a766ffaff607d0f96ed40
```

Verify the UID of the mysql user.

```bash
podman exec mydb2 grep mysql /etc/passwd
# Output:

# mysql:x:27:27:MySQL Server:/var/lib/mysql:/sbin/nologin
```

Stop and remove the the container.

```bash
podman stop mydb2 

podman rm mydb2 
```

Create a directory and set the appropriate permissions inside the user namespace.

```bash
mkdir ~/mydb

podman unshare chown 27:27 mydb
```

Check the UID mapping


```bash
podman unshare cat /proc/self/uid_map
# Output:

        #  0       1000          1
        #  1     100000      65536
```

Verify the directory owner UID that is used in the host OS.

```bash
ls -ld mydb
# Output:

# drwxr-xr-x. 2 100026 100026 6 Jan 19 01:11 mydb
```

Run the rootless container with storage.

```bash
podman run -d --name mydb2 -e MYSQL_ROOT_PASSWORD=password -v /home/tandi/mydb:/var/lib/mysql:Z quay.io/fedora/mariadb-105
# Output:

# 49266de73073fbf2310278fc57fa4c8d46d3048dd3b245f44e4c69dcb32da571
```

Verify the db files have been created.

```bash
ls -Z mydb
# Output:

# system_u:object_r:container_file_t:s0:c148,c192 data
# system_u:object_r:container_file_t:s0:c148,c192 mysql.sock
```


---