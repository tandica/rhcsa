# Attaching storage to containers
## Exercise 26-7


### Step 1: Attach storage to the mariadb container.

Create a directory that grants *others* write permissions.

```bash
mkdir /opt/dbfiles && chmod o+w /opt/dbfiles
```

Run the mariadb container with environment variables. Note that we need to add the 

```bash
podman run -d --name mydb -v /opt/dbfiles:/var/lib/mysql:Z -e MYSQL_USER=tandi -e MYSQL_PASSWORD=pw -e MYSQL_DATABASE=mydb rhel9/mariadb-1011

# Output: 

# ddb1f52cdbc124a7f48f91a27f55520b98a16eb9803b934d1eb70f2c8483210a
```

Check if the container is running.

```bash
podman ps -a
# Output:

# CONTAINER ID  IMAGE                                         COMMAND               CREATED         STATUS                     PORTS                             NAMES
# ddb1f52cdbc1  registry.redhat.io/rhel9/mariadb-1011:latest  run-mysqld            18 minutes ago  Exited (1) 18 minutes ago  3306/tcp  
```

You can see the status of the container is "Exited". Check the logs to see if they give more details.

```bash
podman logs mydb
# Output:

# ...
# => sourcing 50-my-tuning.cnf ...
# ---> 02:52:33     Initializing database ...
# ---> 02:52:33     Running mysql_install_db ...
# mkdir: cannot create directory '/var/lib/mysql/data': Permission denied
# Fatal error Can't create database directory '/var/lib/mysql/data'
# ...
```

We can see the problem is due to permissions. Let's remove the failed container.

```bash
podman rm mydb
```

CHange the permissions of the directory to the current user.

```bash
chmod $(id -un) /opt/dbfiles
```

Run the command for mrunning mariadb again.

```bash
podman run -d --name mydb -v /opt/dbfiles:/var/lib/mysql:Z -e MYSQL_USER=tandi -e MYSQL_PASSWORD=pw -e MYSQL_DATABASE=mydb rhel9/mariadb-1011
# Output:

# f578296e0417330bac7e5bc7dabd000269318075bde6796fe710c69d80084536
```

Check what is in the directory created in the first step.

```bash
ls -ldZ /opt/dbfiles
# Output:

# drwxr-xrwx. 2 root root system_u:object_r:container_file_t:s0 6 Jan 18 21:44 /opt/dbfiles
```

The container_file_t SELinux context has been set automatically.


---