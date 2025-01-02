# Conguring Direct and Indirect Maps to Mount NFS Shares
## Exercise 24-3


### Step 1: Use *autofs* as an automount solution.

In server1, install **autofs**.

```bash
dnf install -y autofs
```

Get the available exports from server2.

```bash
showmount -e server2.example.com
```

Edit the **autofs** master config file

```bash
sudo vim /etc/auto.master
```

Add this:

```
/nfsdata /etc/auto.nfsdata
```

Create and edit the secondary file specified *(/etc/auto.nfsdata)*.

```bash
sudo vim /etc/auto.nfsdata
```

Add this:

```
files -rw server2:/nfsdata
```

Enable and start the autofs service.

```bash
systemctl enable --now autofs
```

Check that the /nfsdata directory is not there.

```bash
ls /
```


---