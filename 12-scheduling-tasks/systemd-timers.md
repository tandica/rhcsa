# Using Systemd timers
## Exercise 12-1
Exploring Systemd timers.

### Step 1: Show a list of all timers


```bash
systemctl list-units -t timer
# Output:

#  UNIT                         LOAD   ACTIVE SUB     DESCRIPTION                                         
#   dnf-makecache.timer          loaded active waiting dnf makecache --timer
#   logrotate.timer              loaded active waiting Daily rotation of log files
#   mlocate-updatedb.timer       loaded active waiting Updates mlocate database every day
#   ...
```


### Step 2: Show the logrotate.service and logrotate.timer files. 

```bash
systemctl list-unit-files logrotate.* 
# Output:

# UNIT FILE         STATE   PRESET 
# logrotate.service static  -      
# logrotate.timer   enabled enabled
```


### Step 3: Show the contents of logrotate.service 

Notice it doesn't have an [Install] section.

```bash
systemctl cat logrotate.service
# Output:

# [Unit]
# Description=Rotate log files
# Documentation=man:logrotate(8) man:logrotate.conf(5)
# RequiresMountsFor=/var/log
# ConditionACPower=true

# [Service]
# Type=oneshot
# ExecStart=/usr/sbin/logrotate /etc/logrotate.conf

# # performance options
# Nice=19
# IOSchedulingClass=best-effort
# IOSchedulingPriority=7

# # hardening options
# #  details: https://www.freedesktop.org/software/systemd/man/systemd.exec.html
# #  no ProtectHome for userdir logs
# #  no PrivateNetwork for mail deliviery
# #  no NoNewPrivileges for third party rotate scripts
# #  no RestrictSUIDSGID for creating setgid directories
# LockPersonality=true
# MemoryDenyWriteExecute=true
# PrivateDevices=true
# PrivateTmp=true
# ProtectClock=true
# ProtectControlGroups=true
# ProtectHostname=true
# ProtectKernelLogs=true
# ProtectKernelModules=true
# ProtectKernelTunables=true
# ProtectSystem=full
# RestrictNamespaces=true
# RestrictRealtime=true
```


### Step 4: Check the status of logrotate.service. 

Notice that it's triggered by logrotate.timer.

```bash
systemctl list-unit-files logrotate.* 
# Output:

# # ○ logrotate.service - Rotate log files
#      Loaded: loaded (/usr/lib/systemd/system/logrotate.service; static)
#      Active: inactive (dead) since Wed 2024-11-13 20:59:55 EST; 9min ago
# TriggeredBy: ● logrotate.timer
#        Docs: man:logrotate(8)
#              man:logrotate.conf(5)
#     Process: 977 ExecStart=/usr/sbin/logrotate /etc/logrotate.conf (code=exited, status=0/SUCCESS)
#    Main PID: 977 (code=exited, status=0/SUCCESS)
#         CPU: 81ms
```


### Step 5: Check the status of logrotate.timer. 

```bash
systemctl list-unit-files logrotate.* 
# Output:

# ● logrotate.timer - Daily rotation of log files
  #    Loaded: loaded (/usr/lib/systemd/system/logrotate.timer; enabled; preset: enabled)
  #    Active: active (waiting) since Wed 2024-11-13 20:59:55 EST; 11min ago
  #     Until: Wed 2024-11-13 20:59:55 EST; 11min ago
  #   Trigger: Thu 2024-11-14 00:00:00 EST; 2h 48min left
  #  Triggers: ● logrotate.service
  #      Docs: man:logrotate(8)
  #            man:logrotate.conf(5)
```


### Step 6: Install sysstat package and vrify that files from this package were added.

```bash
dnf -y install sysstat 

systemctl list-unit-files sysstat.*
# Output:

# UNIT FILE       STATE   PRESET 
# sysstat.service enabled enabled
```


### Step 7: Show the contents of sysstat-collect.timer to see what it's doing.

```bash
dnf -y install sysstat 

systemctl cat sysstat-collect.timer
# Output:

# # /usr/lib/systemd/system/sysstat-collect.timer
# # /usr/lib/systemd/system/sysstat-collect.timer
# # (C) 2014 Tomasz Torcz <tomek@pipebreaker.pl>

# # sysstat-12.5.4 systemd unit file:
# #     Activates activity collector every 10 minutes

# [Unit]
# Description=Run system activity accounting tool every 10 minutes

# [Timer]
# OnCalendar=*:00/10

# [Install]
# WantedBy=sysstat.service
```

The line `OnCalendar=*:00/10` ensures thatit runs every 10 minutes.

---