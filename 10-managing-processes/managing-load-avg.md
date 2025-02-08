# Managing load average
## Exercise 10-3
How to use load average.

### Step 1: Run the following *dd* command 3 times

After running the commands, use **top** to observe the current load average.

```bash
dd if=/dev/zero of=/dev/null &

top
# Output:

  #   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                           
  # 14531 tandi     20   0  220988   1028    936 R  97.0   0.0   0:13.33 dd                                                
  # 14519 tandi     20   0  220988   1028    936 R  96.7   0.0   0:16.52 dd                                                
  # 14524 tandi     20   0  220988   1028    936 R  96.0   0.0   0:14.46 dd 
```

### Step 2: Uptime

Run the **uptime** command and observe the load average slowly increasing.

```bash
uptime
# Output after 3 times running the uptime command with a short time in between each:

#  02:09:47 up  2:56,  2 users,  load average: 0.91, 0.40, 0.48

#  02:12:03 up  2:58,  2 users,  load average: 2.78, 1.35, 0.83

#  02:12:17 up  2:58,  2 users,  load average: 2.83, 1.43, 0.87
```

### Step 3: CPU

Find the number of CPUs and cores per CPU parameter.

```bash
lscpu
# Output:

#  Vendor ID:               GenuineIntel
  # Model name:            Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
  #   CPU family:          6
  #   Model:               158
  #   Thread(s) per core:  1
  #   Core(s) per socket:  1
  #   Socket(s):           4
```

The Core amount is 1 per socket, and there are 4 sockets, which mean that there are 4 Cores (4 CPUs).

### Step 4: Kill processes 

Kill all the dd processes.

```bash
killall dd 
# Output:

# [1]   Terminated              dd if=/dev/zero of=/dev/null
# [2]-  Terminated              dd if=/dev/zero of=/dev/null
# [3]+  Terminated              dd if=/dev/zero of=/dev/null
```

---