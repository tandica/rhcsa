# Changing rsyslog.conf rules
## Exercise 13-4

### Step 1: Set up Apache to point to rsyslog

Ensure Apache is installed and open its config file to check if it has the line `ErrorLog syslog:local1`. If it doesn't, add it. This line allows httpd to use the rsyslog facility of local1.

```bash
dnf -y install httpd

cat /etc/httpd/conf/httpd.conf | grep ErrorLog syslog:local1
# Output does not have the line 

# Add the specified line 
vim /etc/httpd/conf/httpd.conf 

# Restart the service to apply the new config
systemctl restart httpd
```

### Step 2: Configure rsyslog to recieve messages from the httpd service

```bash
vim /etc/rsyslog.conf
# Add the below line at the end of the RULES section of the file 
# local1.error                 /var/log/httpd-error.log

# Create this directory
touch /var/log/httpd-error.log
```

Adding the above line will send all error messages from httpd to the specified path. 

Reload the rsyslog config: 

```bash
systemctl restart rsyslog
```

### Step 3: Test changes 

In the Firefox broswer, go to http://localhost/index.html. Since it doesn't exist, it will throw an error to the error log we created.

View the error file.

```bash
tail /var/log/httpd-error.log
```

---