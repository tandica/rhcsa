
# Lab 11

Lab on working with Systemd.

#### 1. Install the vsftpd and httpd services.

```bash
dnf -y install vsftpd
dnf -y install httpd
```

#### 2. Set the default systemctl editor to vim.

In the **~/.bashrc** file, add thee following line: 

```bash
export SYSTEMD_EDITOR="/bin/vim"
```

#### 3. Edit the httpd.service unit file such that starting httpd will always auto-start vsftpd. Edit the httpd service such that after failure it will automatically start again in 10 seconds.

Create an override file for httpd.service: 

```bash
systemctl edit httpd.service
```

Add this to the file:

```bash
[Unit]
Wants=vsftp.service
```

The **Wants** keyword creates a soft dependency that allows both services to run. 

For the second part of the question, add this to the same file:

```bash
[Service]
Restart=on-failure
RestartSec=10s
```

Reload the service to apply the changes:

```bash
systemctl daemon-reload
```

Enable, start the service and confirm the status is active:
```bash
systemctl enable httpd
systemctl start httpd
systemctl status httpd
# Output: 

# ● httpd.service - The Apache HTTP Server
#      Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
#     Drop-In: /etc/systemd/system/httpd.service.d
#              └─override.conf
#      Active: active (running) since Tue 2024-11-12 21:49:31 EST; 5s ago
#        Docs: man:httpd.service(8)
#    Main PID: 7478 (httpd)
#      Status: "Started, listening on: port 443, port 80"
#       Tasks: 214 (limit: 22798)
#      Memory: 43.1M
#         CPU: 119ms
```

Kill the service and check the status after 10 seconds:

```bash
kill -9 7478

systemctl status httpd 
# Output:

# ● httpd.service - The Apache HTTP Server
#      Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
#     Drop-In: /etc/systemd/system/httpd.service.d
#              └─override.conf
#      Active: active (running) since Tue 2024-11-12 21:59:35 EST; 15s ago
#        Docs: man:httpd.service(8)
#    Main PID: 9071 (httpd)
#      Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
#       Tasks: 214 (limit: 22798)
#      Memory: 44.1M
#         CPU: 113ms
```

The service restarts automatically 10 seconds after the `kill -9` command because it indicates a failure, and we set `Restart=on-failure` in the override file.

---