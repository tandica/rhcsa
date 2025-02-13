# Making the systemd journal persistent
## Exercise 13-3

By default, the journal is stored in /run/log/journal. The /run directory is for only current processes which is why the journal gets wiped when the system reboots. We make the journal persistent in this exercise, so it doesn't get wiped like this. 

### Step 1: Create the directory.

Log in as root and make the **/var/log/journal** directory. This is where we can store the journal so it doesn't get wiped on reboot. 

```bash
su - root

mkdir /var/log/journal
```

### Step 2: Change ownership and permissions of the directory.


```bash
chown root:systemd-journal /var/log/journal

chmod 2755 /var/log/journal 

# Check if the changes were applied properly
cd /var/log
ls -l | grep journal
# Output: 

# drwxr-sr-x. 2 root    systemd-journal       6 Nov 16 18:43 journal
```

The 2 in 2755 in the `chmod` command sets the Group ID (setgid) so that any files or subdirectories under this folder will have the same group ownership the as **journal** directory, making all files automatically owned by systemd-journal.


### Step 3: Reload the systemd-journals 

```bash
systemctl restart systemd-journal-flush
```

The systemd journal will now be persistent across reboots. 


## Another way to do the same thing

1. Create the directory.

```bash
su - root

mkdir /var/log/journal
```

2. Edit the journald.conf file and add the commented line.

```bash
vim /etc/systemd/journald.conf
#Storage=persistent
```

2. Restart the service and verify the persistent logs.
```bash
systemctl restart systemd-journal

ls -l /var/log/journal
```

---