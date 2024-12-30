# Lab 23

Lab on configuring a firewall.

#### 1. Create a firewall configuration that allows access to the following services that may be running on your server: web, ftp, ssh.

Web includes both **http** and **https**. Firewalld uses service names, so no need to change the other 2 services when defining it in the config.

Check if the necessary services are running.

```bash
systemctl status httpd

systemctl status vsftpd

systemctl status sshd
```

Since they're all active and running, I can add the services to the firewall configuration.

```bash
firewall-cmd --add-service=http --permanent
# Output:

# success 

firewall-cmd --add-service=https --permanent
# Output:

# success 

firewall-cmd --add-service=ftp --permanent
# Output:

# success 

firewall-cmd --add-service=ssh --permanent
# Output:

# success 
```


#### 2. Make sure the configuration is persistent and will be activated after a restart of your server.

Reload the firewall config to apply the permanent changes.

```bash
firewall-cmd --reload
# Output:

# success 
```

Verify that the services were added.

```bash
firewall-cmd --list-all
# Output:

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ftp http https ssh vnc-server
```

We can see the list of services includes the ones which we just added.


---