# Scheduling jobs with *at*
## Exercise 12-3
How to schedule jobs for execution at a specific time with *at*.

### Step 1: Check the status of the atd service


```bash
systemctl status atd
# Output: 

# ● atd.service - Deferred execution scheduler
#      Loaded: loaded (/usr/lib/systemd/system/atd.service; enabled; preset: enabled)
#      Active: active (running) since Wed 2024-11-13 21:00:04 EST; 1h 14min ago
#        Docs: man:atd(8)
#    Main PID: 1330 (atd)
#       Tasks: 1 (limit: 22798)
#      Memory: 296.0K
#         CPU: 11ms
#      CGroup: /system.slice/atd.service
#              └─1330 /usr/sbin/atd -f
```

### Step 2: Schedule a job for a time and verify its' place in queue.

After scheduling a task, add a line when atd shell appears.

```bash
at 23:00
# Output:

# warning: commands will be executed using /bin/sh
# at> logger message from at
# at> <EOT>
# job 1 at Wed Nov 13 23:00:00 2024

atq
# Output:

# 1	Wed Nov 13 23:00:00 2024 a root
```

---