# Managing units with *systemctl*
## Exercise 11-1
How to manage units.

### Step 1: From a root shell, type dnf -y install vsftpd to install the Very Secure FTP service. Activate it.


```bash
dnf -y install vsftpd

# Activate the service 
systemctl start vsftpd

# Check that the service has started
systemctl status vsftpd
# Output: 

# ● vsftpd.service - Vsftpd ftp daemon
#      Loaded: loaded (/usr/lib/systemd/system/vsftpd.service; disabled; preset: disabled)
#      Active: active (running) since Mon 2024-11-11 18:34:09 EST; 1min 28s ago
#     Process: 17593 ExecStart=/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf (code=exited, status=0/SUCC>
#    Main PID: 17594 (vsftpd)
#       Tasks: 1 (limit: 22798)
#      Memory: 720.0K
#         CPU: 6ms
#      CGroup: /system.slice/vsftpd.service
#              └─17594 /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# Nov 11 18:34:09 localhost systemd[1]: Starting Vsftpd ftp daemon...
# Nov 11 18:34:09 localhost systemd[1]: Started Vsftpd ftp daemon.
```

You can see in the output in the `Loaded: ...` line that the service is diabled, which means that it won't be activated on a system restart.

It also has `preset: disabled` in this line which means that the vendor preset is disabled, so after installation, the service will not automatically be enabled. 

### Step 2: Create a symbolic link in the wants directory for the multiuser target to ensure that the service is automatically started after a restart.

```bash
systemctl enable vsftpd
# Output:

# Created symlink /etc/systemd/system/multi-user.target.wants/vsftpd.service → /usr/lib/systemd/system/vsftpd.service

# Check the status of the service again to see the changes in the "Loaded" line
systemctl status vsftpd
# Output:

# ● vsftpd.service - Vsftpd ftp daemon
#      Loaded: loaded (/usr/lib/systemd/system/vsftpd.service; enabled; preset: disabled)
#      Active: active (running) since Mon 2024-11-11 18:34:09 EST; 9min ago
#    Main PID: 17594 (vsftpd)
#       Tasks: 1 (limit: 22798)
#      Memory: 720.0K
#         CPU: 6ms
#      CGroup: /system.slice/vsftpd.service
#              └─17594 /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

# Nov 11 18:34:09 localhost systemd[1]: Starting Vsftpd ftp daemon...
# Nov 11 18:34:09 localhost systemd[1]: Started Vsftpd ftp daemon.
```

---