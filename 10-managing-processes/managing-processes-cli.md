# Managing processes from the command line
## Exercise 10-2
How to manage processes.

### Step 1: Run the following *dd* command 3 times

After running the commands, list them and take note of the PID.

```bash
dd if=/dev/zero of=/dev/null &

ps aux | grep dd
# Output: 

# tandi      13101 96.2  0.0 220988  1028 pts/1    R    01:29   0:36 dd if=/dev/zero of=/dev/null
# tandi      13106 98.4  0.0 220988  1024 pts/1    R    01:29   0:34 dd if=/dev/zero of=/dev/null
# tandi      13111 98.3  0.0 220988  1028 pts/1    R    01:29   0:33 dd if=/dev/zero of=/dev/null
```


### Step 2: Kill the processes

Remove the parent process with kill -9 command.

```bash
kill -9 13101
# Output:

# [1]   Killed                  dd if=/dev/zero of=/dev/null
```

The remaining processes still exist because they have been automatically moved to be children of the systemd process. Kill these processes as well.

```bash
killall dd 
# Output:

# [2]-  Terminated              dd if=/dev/zero of=/dev/null
# [3]+  Terminated              dd if=/dev/zero of=/dev/null
```

---