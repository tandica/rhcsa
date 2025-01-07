# Lab 25

Lab on configuring time services.

#### 1. Compare the current hardware time to the system time. If there is a dierence, make sure to synchronize time.

System time:

```bash
date
# Output:

# Tue 07 Jan 2025 01:51:42 AM CET
```

```bash
hwclock
# Output:

# 2025-01-07 01:52:27.994143+01:00
```

There is no difference, but it is different from my local time, so I will set it to my local time.

```bash
timedatectl set-timezone Canada/Eastern 
```

Verify that the system and hardware time matches local time.

```bash
date
# Output:

# Mon 06 Jan 2025 07:55:33 PM EST

hwclock
# Output:

# 2025-01-06 19:57:39.996136-05:00
```


#### 2. Set the time zone to correspond to the current time in Boston (USA East Coast).

```bash
timedatectl set-timezone US/Eastern 
```


---