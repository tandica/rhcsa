# Managing local time
## Exercise 25-1


### Step 1: Explore time commands.

Compare the outoput of `date` and `hwclock`.

```bash
su - root

date
# Output: 

# Mon 06 Jan 2025 07:58:34 AM EST

hwclock
# Output: 

# 2025-01-06 07:58:39.995836-05:00
```

Show current time settings.

```bash
timedatectl status
# Output: 

#                Local time: Mon 2025-01-06 08:01:13 EST
#            Universal time: Mon 2025-01-06 13:01:13 UTC
#                  RTC time: Mon 2025-01-06 13:01:13
#                 Time zone: America/Toronto (EST, -0500)
# System clock synchronized: yes
#               NTP service: active
#           RTC in local TZ: no
```

List all timezones.

```bash
timedatectl list-timezones
# Output: 

# Africa/Abidjan
# Africa/Accra
# Africa/Addis_Ababa
# Africa/Algiers
# Africa/Asmara
# Africa/Asmera
# ...
```


### Step 2: Configure various time settings. 

Set the currennt timezone to Amsterdam.

```bash
timedatectl set-timezone Europe/Amsterdam
```

Compare the new settings with those in #1. 

```bash
timedatectl show
# Output: 

# Timezone=Europe/Amsterdam
# LocalRTC=no
# CanNTP=yes
# NTP=yes
# NTPSynchronized=yes
# TimeUSec=Mon 2025-01-06 14:13:15 CET
# RTCTimeUSec=Mon 2025-01-06 14:13:14 CET
```

Turn NTP on. 

```bash
timedatectl set-ntp 1
```

Look at the status of the chronyd service. This is the service that `timedatectl set-ntp` talks to. 

```bash
systemctl status chronyd
# Output: 

# chronyd.service - NTP client/server
#      Loaded: loaded (/usr/lib/systemd/system/chronyd.service; enabled; preset: enabled)
#      Active: active (running) since Sun 2025-01-05 21:56:36 CET; 16h ago
#        Docs: man:chronyd(8)
#              man:chrony.conf(5)
#     Process: 1030 ExecStart=/usr/sbin/chronyd $OPTIONS (code=exited, status=0/SUCCESS)
#    Main PID: 1078 (chronyd)
#       Tasks: 1 (limit: 22823)
#      Memory: 4.2M
#         CPU: 205ms
#      CGroup: /system.slice/chronyd.service
#              └─1078 /usr/sbin/chronyd -F 2

# Jan 05 21:56:36 localhost chronyd[1078]: Loaded seccomp filter (level 2)
# Jan 05 21:56:43 localhost chronyd[1078]: Selected source 174.138.207.42 (2.rhel.pool.ntp.org)
# Jan 05 21:56:43 localhost chronyd[1078]: System clock wrong by -3.302072 seconds
# Jan 05 21:56:40 localhost chronyd[1078]: System clock was stepped by -3.302072 seconds
# Jan 05 21:56:40 localhost chronyd[1078]: System clock TAI offset set to 37 seconds
# Jan 06 13:21:44 localhost chronyd[1078]: Forward time jump detected!
# Jan 06 13:21:44 localhost chronyd[1078]: Can't synchronise: no selectable sources
# Jan 06 13:23:53 localhost chronyd[1078]: Selected source 158.69.48.17 (2.rhel.pool.ntp.org)
# Jan 06 13:23:53 localhost chronyd[1078]: System clock wrong by -4.563242 seconds
# Jan 06 13:27:06 localhost chronyd[1078]: Selected source 174.138.207.42 (2.rhel.pool.ntp.or
```


---