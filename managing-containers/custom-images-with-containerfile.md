# Building custom images with a Containerfile
## Exercise 26-3


### Step 1: Create a custom image.

Create directory to host the Containerfile.

```bash
mkdir ex26-3 && cd ex26-3
```

Create the image file and put the necessary contents.

```bash
vim customimg
```

Put this inside the file:

```bash
FROM docker.io/library/alpine
RUN apk add nmap
CMD ["nmap", "-sn", "172.16.0.0/24"]
```

Build the image. You may need to specify the Containerfile and folder with the **-f** option.

```bash
podman build -t alpmap:1.0 -f customimg .
# Output:

# STEP 1/3: FROM docker.io/library/alpine
# Trying to pull docker.io/library/alpine:latest...
# Getting image source signatures
# Copying blob 1f3e46996e29 done   | 
# Copying config b0c9d60fc5 done   | 
# Writing manifest to image destination
# STEP 2/3: RUN apk add nmap
# fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
# fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/x86_64/APKINDEX.tar.gz
# (1/6) Installing libgcc (14.2.0-r4)
# (2/6) Installing lua5.4-libs (5.4.7-r0)
# (3/6) Installing libpcap (1.10.5-r0)
# (4/6) Installing libssh2 (1.11.1-r0)
# (5/6) Installing libstdc++ (14.2.0-r4)
# (6/6) Installing nmap (7.95-r1)
# Executing busybox-1.37.0-r9.trigger
# OK: 23 MiB in 21 packages
# --> 174a36f01a77
# STEP 3/3: CMD ["nmap", "-sn", "172.16.0.0/24"]
# COMMIT alpmap:1.0
```

Verify the image is available.

```bash
podman images
# Output:

# REPOSITORY                       TAG         IMAGE ID      CREATED         SIZE
# localhost/alpmap                 1.0         f9c381c59cf8  19 minutes ago  27.6 MB
# registry.access.redhat.com/ubi9  latest      4d9d35858951  4 days ago      234 MB
# docker.io/library/alpine         latest      b0c9d60fc5e3  5 days ago      8.13 MB
# docker.io/library/nginx          latest      f876bfc1cc63  6 weeks ago     196 MB
# docker.io/library/busybox        latest      af4709625109  3 months ago    4.52 MB
```

Run the image. If it gives an "Couldn't open a raw socket. Error: Operation not permitted (1)" error, then run the same command with elevated privilege to allow *nmap* to use raw sockets: `podman run --cap-add=NET_RAW --cap-add=NET_ADMIN alpmap:1.0`.

```bash
podman run alpmap:1.0
# Output:

# Starting Nmap 7.95 ( https://nmap.org ) at 2025-01-13 13:28 UTC
# Nmap scan report for 172.16.0.0
# Host is up (0.0022s latency).
# Nmap scan report for 172.16.0.1
# Host is up (0.000097s latency).
# Nmap scan report for 172.16.0.2
# ...
```


---