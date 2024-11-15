# Lab 12

Lab on working with scheduling tasks.

#### 1. Create a cron job that performs an update of all software on your computer every evening at 11 p.m.

Log in as root.

```bash
crontab -e

# In the vim editor, add the following line
0 23 * * * dnf -y update
#Save the file
```

0->Minutes

23->Hour

*->day of month

*->month

*->day of week

#### 2. Schedule your machine to be rebooted at 3 a.m. tomorrow morning

```bash
# Check that the atd service is running and enabled
systemctl status atd

at 3:00 AM tomorrow
# add the below line to reboot the machine
# at> sudo reboot
# ctrl + D to exit the atd shell
# Output: 

# job 3 at Fri Nov 15 03:00:00 2024
```

#### 3. Use a systemd timer to start the vsftpd service five minutes after your system has started.

Create a new timer file.

```bash
vim /etc/systemd/system/vsftpd-start.timer
```

In the vim editor, add this configuration: 

```bash
[Unit]
Description=Start vsftpd service 5min after boot

[Timer]
OnBootSec=5min
Unit=vsftpd-start.service

[Install]
WantedBy=multi-user.target
```
`Unit=vsftpd-start.service` tells the timer which service to start.

We need the `[Install]` section, otherwise the service won't start automatically at boot.

Create a service file for the timer. 

```bash
vim /etc/systemd/system/vsftpd-start.service
```

In the vim editor, add this configuration: 

```bash
[Unit]
Description=Start vsftpd service 

[Service] 
Type=oneshot
ExecStart=/bin/systemctl start vsftpd
```

`Type=oneshot` specifies that the task is a one time occurence.

`ExecStart=/bin/systemctl start vsftpd` tells Systemd what command to run when the timer begins. 

---