# Managing container environment variables
## Exercise 26-6


### Step 1: Investigate environment variable errors from a container that requires them.

Run the **mariadb** container.

```bash
podman run docker.io/library/mariadb
# Output: 

# ...
# 2025-01-18 01:30:19+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:11.6.2+maria~ubu2404 started.
# 2025-01-18 01:30:41+00:00 [Warn] [Entrypoint]: /sys/fs/cgroup///memory.pressure not writable, functionality unavailable to MariaDB
# 2025-01-18 01:30:41+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
# 2025-01-18 01:30:41+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:11.6.2+maria~ubu2404 started.
# 2025-01-18 01:30:41+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified
# 	You need to specify one of MARIADB_ROOT_PASSWORD, MARIADB_ROOT_PASSWORD_HASH, MARIADB_ALLOW_EMPTY_ROOT_PASSWORD and MARIADB_RANDOM_ROOT_PASSWORD
```

We get an error here because this container needs the specified environment variables. You can see the output of the failed container.

```bash
podman ps -a
# Output: 

# CONTAINER ID  IMAGE                             COMMAND               CREATED         STATUS                     PORTS                         NAMES
# d32250c75c97  docker.io/library/mariadb:latest  mariadbd              34 minutes ago  Exited (1) 34 minutes ago  3306/tcp                      gallant_hypatia
```

Inspect the mariadb container and look for a *usage* line (it won't be there).

```bash
podman inspect mariadb
```

Find the exact version of the mariadb image in the RHEL registry

```bash
podman search mariadb
# Output:

# ...
# registry.redhat.io/rhscl/mariadb-100-rhel7                    MariaDB 10.0 SQL database server
# registry.redhat.io/rhel8/mariadb-105                          MariaDB 10.5 SQL database server
# registry.redhat.io/rhel9/mariadb-1011                         rhcc_registry.access.redhat.com_rhel9/mariad
# ...
```

Run the version you want. It still won't work, but you'll get a more detailed output of what you need. Login if you dont have the access.

```bash
podman run registry.redhat.io/rhel9/mariadb-1011 
# Output:

# ...
# You must either specify the following environment variables:
#   MYSQL_USER (regex: '^[a-zA-Z0-9_]+$')
#   MYSQL_PASSWORD (regex: '^[a-zA-Z0-9_~!@#$%^&*()-=<>,.?;:|]+$')
#   MYSQL_DATABASE (regex: '^[a-zA-Z0-9_]+$')
# Or the following environment variable:
#   MYSQL_ROOT_PASSWORD (regex: '^[a-zA-Z0-9_~!@#$%^&*()-=<>,.?;:|]+$')
# Or both.
#  ...
```

Inspect the image from the RHEL registry with the specific version and look for *usage*.

```bash
podman inspect registry.redhat.io/rhel9/mariadb-1011 | grep usagetandi

# Output:

# "usage": "podman run -d -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 rhel9/mariadb-1011",
#  "usage": "podman run -d -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 rhel9/mariadb-1011",
#       "created_by": "/bin/sh -c #(nop) CMD [\"base-usage\"]",
#       "created_by": "/bin/sh -c #(nop) LABEL summary=\"$SUMMARY\"       description=\"$DESCRIPTION\"       io.k8s.description=\"$DESCRIPTION\"       io.k8s.display-name=\"MariaDB 10.11\"       io.openshift.expose-services=\"3306:mysql\"       io.openshift.tags=\"database,mysql,mariadb,mariadb1011,mariadb-1011\"       com.redhat.component=\"mariadb-1011-container\"       name=\"rhel9/mariadb-1011\"       version=\"1\"       usage=\"podman run -d -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 rhel9/mariadb-1011\"       maintainer=\"SoftwareCollections.org <sclorg@redhat.com>\"",
# ...
```

In the first line of the above output, you can see exactly how to how to run the container image.

```bash
podman run -d -e MYSQL_USER=tandi -e MYSQL_PASSWORD=tandi -e MYSQL_DATABASE=db -p 3306:3306 rhel9/mariadb-1011
# Output:

# f578296e0417330bac7e5bc7dabd000269318075bde6796fe710c69d80084536
```

Check that the container is running.

```bash
podman ps
# Output:

# CONTAINER ID  IMAGE                                         COMMAND     CREATED        STATUS        PORTS                             NAMES
# f578296e0417  registry.redhat.io/rhel9/mariadb-1011:latest  run-mysqld  5 minutes ago  Up 5 minutes  0.0.0.0:3306->3306/tcp, 3306/tcp  beautiful_shirley
```


---