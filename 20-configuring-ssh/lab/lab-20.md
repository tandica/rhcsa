# Lab 20

Lab on configuring SSH.

#### 1. Configure your SSH server in such a way that inactive sessions will be kept open for at least one hour.

Open the SSH config file as a root user.

```bash
vim /etc/ssh/sshd_config
```

Add the following lines: 

```bash
ClientAliveInterval 3600
ClientAliveCountMax 0
```

> **ClientAliveInterval** is set to 1 hour in seconds (3600). This sets the timeout to 1 hour after the last activity.

> **ClientAliveCountMax** is set to 0 so that the connection will be kept alive as long as the packets are sent

Restart the ssh service to load the new configuration.

```bash
systemctl restart sshd
```


#### 2. Secure your SSH server so that it listens on port 2202 only and that only user student is allowed to log in.

Make these edits to the ssh config file: 
- Add `Port 2202` and ensure `Port 22` is specified as well
- In the `AllowUsers` parameter, include the user **student**.

```bash
vim /etc/ssh/sshd_config
```

Restart the ssh service to apply the changes.

```bash
systemctl restart sshd
```

Add the necessary changes so SELinux doesn't cause an error with the new port.

```bash
semanage -a -t ssh_port_t -p tcp 2202
```

Make the necessary firewall changes to the new port.

```bash
firewall-cmd --add-port=2202/tcp 

firewall-cmd --add-port=2202/tcp --permanent 

firewall-cmd --reload
```


---
