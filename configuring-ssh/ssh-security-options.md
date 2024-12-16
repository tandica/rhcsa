# Configuring SSH security options
## Exercise 20-1


### Step 1: Change the default port and user access for server1.

Create a script that outputs the message "hello world".

**1.1. Log into server1**

```bash
ssh tandi@server1
```


**1.2. Edit the config file to change the default port and add an allowed user**

```bash
vim /etc/ssh/sshd_config
```

Add the below line which specifies a non-default port for server1 to point to, right under the existing Port declaration. Ensure the default port is uncommented to specify that there are multiple ports *ssh* should be listening to.

```bash
Port 22
Port 2202
```

Add this line at the end of the file to allow user *student* to access the server:

```bash
AllowUsers student
```

Save the file.


### Step 2: Verify changes.

**1.1. Verify changes and look at logs**

Run the following command to restart the service and apply the changes you've made:

```bash
systemctl restart sshd
# Output:

# Job for sshd.service failed because the control process exited with error code.
# See "systemctl status sshd.service" and "journalctl -xeu sshd.service" for details.
```

You will have an error messsage.

Run one of the commands in the output to learn more about the error:

```bash
journalctl -xeu sshd.service
# Output:

# ...
# Dec 16 11:26:43 localhost sshd[19625]: error: Bind to port 2202 on 0.0.0.0 failed: Permission denied.
# Dec 16 11:26:43 localhost sshd[19625]: error: Bind to port 2202 on :: failed: Permission denied.
# Dec 16 11:26:43 localhost sshd[19625]: fatal: Cannot bind any address.
# ...
```

Notice the *Permission denied* error.


**1.2. Apply the correct SELinux labels to port 2202**

Apply the corect SELinux labels so **ssh** can use this port.

```bash
sudo semanage port -a -t ssh_port_t -p tcp 2202
```


**1.3. Configure the firewall for port 2202**

```bash
sudo firewall-cmd --add-port=2202/tcp
# Output:

# success

sudo firewall-cmd --add-port=2202/tcp --permanent
# Output:

# success
```

**1.4. Reload the chages and verify that *ssh* is listening on 2 different ports**

Reload the firewall.

```bash
sudo firewall-cmd --reload
```

Restart the service. 

```bash
systemctl restart sshd
```

Check the status of the service. 

```bash
systemctl restart sshd
# Output:

# ...
# Dec 16 12:42:23 localhost systemd[1]: Starting OpenSSH server daemon...
# Dec 16 12:42:23 localhost sshd[25358]: Server listening on 0.0.0.0 port 2202.
# Dec 16 12:42:23 localhost sshd[25358]: Server listening on :: port 2202.
# Dec 16 12:42:23 localhost sshd[25358]: Server listening on 0.0.0.0 port 22.
# Dec 16 12:42:23 localhost sshd[25358]: Server listening on :: port 22.
# Dec 16 12:42:23 localhost systemd[1]: Started OpenSSH server daemon.
```

From the logs, you can see that the server is now listening on both port 22 and 2202.


---