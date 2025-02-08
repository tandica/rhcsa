
# Lab 10

Lab on managing processes.

#### 1. Launch the command dd if=/dev/zero of=/dev/null three times as a background job.

```bash
dd if=/dev/zero of=/dev/null &
dd if=/dev/zero of=/dev/null &
dd if=/dev/zero of=/dev/null &
```

#### 2. Increase the priority of one of these commands using the nice value -5. Change the priority of the same process again, but this time use the value -15. Observe the difference.

```bash
renice -5 -p 6251
# Output: 

# 6251 (process ID) old priority 0, new priority -5

renice -15 -p 6251
# Output: 

# 6251 (process ID) old priority -5, new priority -15
```

Use **top** to observe the differences.

#### 3. Kill all the dd processes you just started.

This involves setting the group id (SGID): 

```bash
killall dd
```

#### 4. Ensure that tuned is installed and active, and set the throughput-performance profile.

```bash
dnf install -y tuned

# Check if tuned is active
systemctl status tuned

# Activate tuned
systemctl enable --now tuned

# Check the current profile
tuned-adm active
# Output: 
# Current active profile: virtual-guest

# Change profile to throughput-performance
tuned-adm profile throughput-performance

# Check that the profile changed
tuned-adm active
# Output: 
# Current active profile: throughput-performance

```
