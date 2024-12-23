# Changing port labels
## Exercise 22-5


### Step 1: Change the port label for Apache.

Go into the main Apache config file and change the port under `Listen` to 82, instead of the default 80.

```bash
vim /etc/httpd/conf/httpd.conf
```

Restart the Apache service with the new config.

```bash
systemctl restart httpd
# Output:

# Job for httpd.service failed because the control process exited with error code.
# See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
```

There is an error because the new port number does not have the correct SELinux labels to work.

Try restarting the Apache service in *permissive* mode.

```bash
setenforce 0

systemctl restart httpd
```

It works in this mode, so you know the problem is caused by SELinux. Switch back to *enforcing* mode.

```bash
setenforce 1
```

Apply the correct labels to the new port and restart the service.

```bash
semanage port -a -t http_port_t -p tcp 82

systemctl restart httpd
```

It will restart with out any issues now that the port has the correct SELinux labels.


---