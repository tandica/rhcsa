# Lab 24

Lab on accessing network storage and monting network file systems (NFS).

#### 1. Set up an NFS server that shares the /home directory on server2.

Since the /home directory already exists, we don't need to create it.

Add the directory to the **/etc/exports** file.

```bash
su - root 

vim /etc/exports
```

Add this line to define the NFS share: 

```
/home *(rw,no_root_squash)
```

> `no_root_squash` allows root users on client machines to act as root on the NFS share.

Ensure the necessary NFS packages are installed and enable the NFS server.

```bash
dnf install -y nfs-utils

systemctl enable --now nfs-server
```

Add the **nfs**, **mountd** and **rpc-bind** services to the firewall to avoid and errors or blockers.

```bash
firewall-cmd --add-service=nfs --permanent
firewall-cmd --add-service=mountd --permanent
firewall-cmd --add-service=rpc-bind --permanent

firewall-cmd --reload
```

Verify the available exports by checking if /home is in the output of the below command.

```bash
showmount -e server2.example.com
```


#### 2. Congure server1 to access the NFS-shared home directory using automount. You need to do this using wildcard automount.

On server1, edit the **autofs** master config file (/etc/auto.master).

```bash
vim /etc/auto.master
```

Add this line to include the target directory and secondary file:

```
/home        /etc/auto.home
```

Create the secondary file.

```bash
vim /etc/auto.home
```

Add the necesary config to the secondary file:

```
*     -rw     server2:/home/&
```

Restart the autofs service.

```bash
systemctl restart autofs
```

Check that you have access to the mounted directory on server1.

```bash
ls /home/tandi
```

When you access this directory, it automatically mounts the shared directory form server2.


---