
# Lab 13

Lab on configuring logging.

#### 1. Configure the journal to be persistent across system reboots.

**1.1. Create the directory.**

Log in as root and make the **/var/log/journal** directory. This is where we can store the journal so it doesn't get wiped on reboot. 

```bash
su - root

mkdir /var/log/journal
```

**1.2. Change ownership and permissions of the directory.**


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


**1.3. Reload the systemd-journals.**

```bash
systemctl restart systemd-journal-flush
```

The systemd journal will now be persistent across reboots. 


#### 2. Make a configuration file that writes all messages with an info priority to the file /var/log/messages.info.

**2.1. Update /etc/rsyslog.d/messages-info.conf** 

Edit the /etc/rsyslog.d/messages-info.conf file - include this line: 

`*.info                           /var/log.messages.info`

**2.2. Create file for logs to be written to**

Create the file to write the log messages to (/var/log/messages.info) and change permissions:
touch /var/log.messages.info

Restart rysylog 

```bash
touch /var/log.messages.info

chmod 640 /var/log/messages.info
```

**2.3 Restart the rsyslog service and test using logger.**

```bash
systemctl restart rsyslog

logger -p user.info "This is a test log message for info priority"

# Check the output of the log file created
# Look for the log message you just createc
cat /var/log/messages.info
# Output: 

# Nov 17 08:22:38 localhost root[20216]: This is a test log message for info priority
```

#### 3. Configure logrotate to keep ten old versions of log files.

```bash
vim /etc/lograte.conf
```

Change `rotate 4` to `rotate 10` and save the file.

Test the changes: 

```bash
logrotate -d /etc/logrotate.conf
```

Examine the output and notice on multiple lines it has `(10 rotations)`. It means the change was successful.


---