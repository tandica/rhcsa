# changing unit configuration
## Exercise 11-2
Exploring unit configuration.

### Step 1: Install the Apache web server package.

```bash
dnf -y install httpd
```

### Step 2: Show the current configuration of the unit file that starts the Apache web server.

```bash
systemctl cat httpd.service
# Output:

# [Unit]
# Description=The Apache HTTP Server
# Wants=httpd-init.service
# After=network.target remote-fs.target nss-lookup.target httpd-init.service
# Documentation=man:httpd.service(8)

# [Service]
# Type=notify
# Environment=LANG=C

# ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
# ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# # Send SIGWINCH for graceful stop
# KillSignal=SIGWINCH
# KillMode=mixed
# PrivateTmp=true
# OOMPolicy=continue

# [Install]
# WantedBy=multi-user.target
```

### Step 3: Get an overview of available configuration options for this unit file.

```bash
systemctl show httpd.service
# Output:

# Type=notify
# ExitType=main
# Restart=no
# NotifyAccess=main
# RestartUSec=100ms
# TimeoutStartUSec=1min 30s
# TimeoutStopUSec=1min 30s
# TimeoutAbortUSec=1min 30s
# ...
```

### Step 4: Change the default configuration: add a [Service] section that includes the Restart=always and RestartSec=5s lines. Reload the service to ensure Systemd gets the new config. 

```bash
systemctl edit httpd.service

systemctl daemon-reload
```

### Step 5: Start the httpd service and systemctl status sshd to verify that the sshd service is running.

```bash
systemctl start httpd

systemctl status sshd
```

### Step 6: Kill the httpd process.

```bash
killall httpd
```

### Step 7: Type systemctl status httpd and then repeat after 5 seconds. 

Notice that the httpd process gets automatically restarted.

```bash
systemctl status httpd
# Output: 

# ○ httpd.service - The Apache HTTP Server
#      Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; preset: disabled)
#      Active: inactive (dead)
#        Docs: man:httpd.service(8)

# Nov 11 19:58:00 localhost systemd[1]: Starting The Apache HTTP Server...
# Nov 11 19:58:00 localhost httpd[21624]: AH00558: httpd: Could not reliably determine the server's fully qualifie>
# Nov 11 19:58:00 localhost httpd[21624]: Server configured, listening on: port 443, port 80
# Nov 11 19:58:00 localhost systemd[1]: Started The Apache HTTP Server.
# Nov 11 19:59:29 localhost systemd[1]: httpd.service: Deactivated successfully.
```

---