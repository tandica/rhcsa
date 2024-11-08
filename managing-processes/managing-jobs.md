# Managing Jobs
## Exercise 10-1
How to manage jobs.

### Step 1: Run the following commands

```bash
sleep 3600 &
# Output: [1] 5786

dd if=/dev/zero of=/dev/null &
# Output: [2] 5800

sleep 7200
```
The last command didn't have an **&**, meaning it was executed to run in the foreground and not the background like the previous 2. Type **ctrl + z** to stop the command.

### Step 2: View jobs

View all jobs on your system.

```bash
jobs
# Output:

# [1]   Running                 sleep 3600 &
# [2]-  Running                 dd if=/dev/zero of=/dev/null &
# [3]+  Stopped                 sleep 7200
```

### Step 3: Move a job to the background

Job #3 in the above output has been stopped and we will move it to the background with the given id of 3.

```bash
bg 3
# Output: [3]+ sleep 7200 &

jobs
# Output:

# [1]   Running                 sleep 3600 &
# [2]-  Running                 dd if=/dev/zero of=/dev/null &
# [3]+  Running                 sleep 7200 &
```
Job 3 is now running in the background. 

### Step 4: Remove a job

Move jobs to the foreground and then cancel them with **ctrl + c**.

```bash
fg 1
# Type ctrl+c and check if the job was removed

jobs 
# Output: 

# [2]-  Running                 dd if=/dev/zero of=/dev/null &
# [3]+  Running                 sleep 7200 &

# We can see that its been removed, repeat for jobs 2 and 3.

fg 2
# Type ctrl+c
jobs
# Output:

# [3]+  Running                 sleep 7200 &

fg 3
# Type ctrl+c
jobs
# No output.
```

### Step 5: Use 2 terminals

Open a second terminal window and login as root.
Type the following command and close the terminal.

```bash
dd if=/dev/zero of=/dev/null &

exit
```

In the first terminal, type the command **top** and notice the previous **dd** command is running. 

```bash
top
# Output: 

# PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND             
# 6882 root      20   0  220988   1020    932 R  95.7   0.0   2:50.38 dd                  

```
Kill the process - still inside of **top**, press K and enter the PID of the **dd** process to terminate.  

```bash 
#PID to signal/kill [default pid = 6882] 6882

# After killing the process: 
# MiB Mem :   3623.0 total,    151.5 free,   1803.6 used,   1919.0 buff/cache
# MiB Swap:   8192.0 total,   8039.7 free,    152.2 used.   1819.4 avail Mem 

#     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND             
#    4219 tandi     20   0 4052720 157996  73124 S   2.7   4.3   0:18.60 gnome-shell         
#    4911 tandi     20   0  763352  39460  26804 S   0.7   1.1   0:03.44 gnome-terminal-     
#     983 root      20   0  530024   8212   4960 S   0.3   0.2   0:09.80 vmtoolsd            
#    4406 root      20   0  240568   7948   6444 S   0.3   0.2   0:13.90 sssd_kcm            
#    4502 tandi     20   0  535152  24556  17408 S   0.3   0.7   0:09.97 vmtoolsd    
```

Notice that the dd process is gone after killing it. 

---