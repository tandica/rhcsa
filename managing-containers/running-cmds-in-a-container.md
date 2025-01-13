# Running commands in a container
## Exercise 26-4


### Step 1: Run commands inside *nginx* container.

Run an nginx container detached, that is automatically removed when it stops and is named "web2".

```bash
podman run -d --rm --name=web2 docker.io/library/nginx
# Output:

# 630e945dcd4d3cac88b95d4be0b7395182742214dbef02231a39e07f5e8e6bc6
```

Verify the container is available.

```bash
podman ps
# Output: 

# CONTAINER ID  IMAGE                           COMMAND               CREATED             STATUS             PORTS       NAMES
# 630e945dcd4d  docker.io/library/nginx:latest  nginx -g daemon o...  About a minute ago  Up About a minute  80/tcp      web2
```

Open a bash shell inside the container.

```bash
podman exec -it web2 /bin/bash
# Output: 

# root@630e945dcd4d:/#
```

Type `ps aux` inside the shell and notice it doesn't exist because many containers don't come with the standard functionality.

```
root@630e945dcd4d:/# ps aux
bash: ps: command not found
```

Find the process info in the /proc directory.

```
root@630e945dcd4d:/# ls /proc/
1	bootconfig  diskstats	   iomem	kpagecount  mtrr	  stat		 version
24	buddyinfo   dma		   ioports	kpageflags  net		  swaps		 vmallocinfo
25	bus	    driver	   irq		loadavg     pagetypeinfo  sys		 vmstat
26	cgroups     dynamic_debug  kallsyms	locks	    partitions	  sysrq-trigger  zoneinfo
27	cmdline     execdomains    kcore	mdstat	    schedstat	  sysvipc
28	consoles    fb		   key-users	meminfo     scsi	  thread-self
30	cpuinfo     filesystems    keys		misc	    self	  timer_list
acpi	crypto	    fs		   kmsg		modules     slabinfo	  tty
asound	devices     interrupts	   kpagecgroup	mounts	    softirqs	  uptime
```

Find the nginx process that has been started as PID 1.

```
root@630e945dcd4d:/# cat /proc/1/cmdline 
nginx: master process nginx -g daemon off;
```

Exit the shell and ensure the container is still running.

```bash
podman ps
# Output: 

# CONTAINER ID  IMAGE                           COMMAND               CREATED         STATUS         PORTS       NAMES
# 630e945dcd4d  docker.io/library/nginx:latest  nginx -g daemon o...  11 minutes ago  Up 11 minutes  80/tcp      web2
```

### Step 2: Run commands inside *ubuntu* container. 

Check the current kernel version.

```bash
uname -r
# Output:

# 5.14.0-503.19.1.el9_5.x86_64
```

Run the Ubuntu image as an interactive shell.

```bash
podman run -it docker.io/library/ubuntu
```

Confirm that it is an Ubuntu container once you are in the container's shell.

```
root@ca17289c02a0:/# cat /etc/os-release 
PRETTY_NAME="Ubuntu 24.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.1 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```

Check the current kernel version from within the container.

```
root@ca17289c02a0:/# uname -r
5.14.0-503.19.1.el9_5.x86_64
```

Notice it's the same as when you were not inside the container as all containers run on the same kernel.

Exit the container and check that it's not listed, since we did not add the detached (**-d**) option when running it.

```bash 
podman ps
# Output:

# CONTAINER ID  IMAGE                           COMMAND               CREATED         STATUS         PORTS       NAMES
# 630e945dcd4d  docker.io/library/nginx:latest  nginx -g daemon o...  19 minutes ago  Up 19 minutes  80/tcp      web2
```


---