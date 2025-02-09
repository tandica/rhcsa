# Chapter 10: Managing Processes

Every th ing happening on Linux involves a process starting. 

3 process types:
1. Shell jobs
    - commands started from the command line 
    - asdociated with the shell that was current when the process started 
    - also referred to as interactive processes

2. Daemons
    - processes that provide services 
    - normally starts when a computer is booted
    - often, but not always, runs with root privilege

3. Kernel threads
    - part of the linux kernel
    - can't be managed with common tools 
    - important to keep an eye on for the monitoring of performance on a system

**thread**
- a task started by a process
- a basic unit of CPU execution within a process
- a process can have one or more threads 
- smaller unit of a process that shares the processes resources but can be executed independently 

**shell job**: when a user types a command, a shell job is started 

**foreground process**: any executed command is started as a foreground process
- commands will take a few seconds to complete until you can use the CLI again so you can't do anything on the terminal until the command has executed

**background processes**: you can start commands in the background when they don't require user (your) interaction &/or they take long to complete

**& (used at the end of the command line)** starts the job immediately in the background

`fg` brings the last job that was sent to the background to the foreground. If there are multiple jobs, you can get the id of a specific job with the `jobs` command and add it as an argument.

`jobs` shows which jobs are running from the shell. Also, shows details like job id which can be used as an argument for `fg` and `bg` commands. 

**Ctrl + z** temporarily stops the job so it can be managed. For instance, after doing this, you can use `bg` to move the job into the background.

**Ctrl + c** cancels a job and removes it from memory. Sometimes, things don't get closed properly.

**Ctrl + d** sends EOF (end of file) character to the current job to tell it to stop waiting for further input. The job stops waiting for input then terminates, allowing it to close properly using *ctrl + c*.

**Processes** start in a shell.
- process becomes the child of that shell
- all foreground processes are terminated when the shell is stopped
- background processes won't be terminated like this - you need to use the `kill` command to do this. It's used to stop once the shell srtopped, but not anymore.

**Tasks** are started as processes.
- one process can start several 'worker' threads 
- work with threads because they can be handled by different CPUs or CPU cores when a process is busy
- linux admins don't manage threads, they manage processes

2 types of background processes:
1. **kernel threads**
    - part of the linux kernel
    - each has its own process id number (PID)
    - recognized through the name in square brackets
    - cannot be managed, adjusted or killed

2. **daemon processes**

`ps` without any arguments, it shows only processs hat have been started by the current user

`ps aux` shows the summary of all active processes.

`ps -ef` shows the name and command that was used to start the process.

`ps fax` shows hierarchical relationships between parent and child processes.

`pgrep dd` lists all PIDs that have a name containing the string "dd".

**cgroups** are used to allocate system resources in linux. There are 3 types: 3 system areas or "slices".
1. **system**: where all Systemd-managed processes are running.
2. **user**: where all user processes are running (includes root processes).
3. **machine**: optional slice user for virtual machines and containers

All slices have the same CPU weight. CPU capacity is equally divided.

** By default, processes are equal and started with the same priority - **priority # 0**. It can be useful to change the default priority.

`top` monitors a system's resource usage in real time. Ypu can use "r" to change the priority of a currently running process. You can also use `nice` or `renice`, depending on if it's a new or existing process.

**Nice value** is a number from -20 (highest priority) to 19 (lowest priority).
- by default, **most processes start with a nice value of 0**. 

`nice` starts a **new** process with a specified nice value.
- *Ex:* `nice -n [nice-value] [command]` : `nice -n 15 mytask`

`renice` adjusts the nice value of an **existing, running** process
- Change the priority of process based on the PID
- *Ex:* `renice [nice-value] -p [PID]` : `renice 10 -p 1234`

** There are 2 scenarios where you can change the process priority:

1. Starting a backup that doesn't have to finish fast. Backups are usually resource intensive, so lowering its priority will bother other users less.

2. Starting an important calculation job. Give it increased priority to handle it as fast as possible.

Never set the priority directly to -20, as it can block other processes from getting served.

If you kill a parent process, the child processes are not killed. They automatically become children of the Systemd process.

The linux keernel allows signals to be sent to processes.

`kill` sends a signal to the process.

`kill -l` lists all signals you can use with kill, along with their numbers.
- *Ex:* SIGTERM has a signal number of 15, so it can be used like this: `kill -15 PID` or explicitly specify it like `kill -TERM PID`.

**SIGTERM**: ask a process to stop.

**SIGKILL**: force a process to stop.

**SIGHUP**: hang up a process. Makes the process reread the config files. Useful if changes were made to config files.

`killall` terminates processes by name. Useful to stop multiple instances of a program at once. Targets all processes with the specified name.
- *Ex:* `killall firefox`

`pkill` can send signals to processes based on name and other attributes, can get very specific. Has many filtering options.
- *Ex:* to terminate processes started by a specific user: `pkill -u user process_name`

**Load average** is the number of processes in a running state (R) or blocking state (D). Load average is shown for t he last 1, 5 and 15 mins. You can also use the `uptime` command to show current load average stats.

**tuned** optimizes performance of the system by applying certain config based on workload or system environment. It uses profile which contain system parameters tailored for specific scenarios like low latency =, energy savings, etc.

#### Linux Process Table States

**R (Running)** - process is active and using CPU or in queue of runnable processes waiting to get services
 
**S (Sleeping)** - process is waiting for an event to complete

**D (Uninterruptable Sleep/Blocking State)** - process is in a sleep state that can't be stopped. Usually happens when it's waiting for input/output. and also known as "blocking state".

**T (Stopped/Terminated)** - process has been stopped . Typically happens to interactive shell processes with "ctrl + z".

**Z (Zombie)** - process has been stopped but could not be removed by the parent, which puts it in an unmanageable state 



### Do you already know? Questions

1. A cron job and a thread are not considered processes. They are subdivisions of the 2 types shell job and daemon. These 2 need a different management approach. 

2. To move a job to the background, type **ctrl + z** to temporarily freeze it, then `bg` to mkve it to the background. 

3. **ctrl + c** cancels a current interactive shell job. **ctrl + d** sends EOF (end of file) charscter to the current job which would result in a stop *only if* it lets the job complete properly. **ctrl + z** freezes the job. 

4. Threads can't be managed individually by an admin. Multithreaded processes can make working with processes more efficient. Multiple threads are more efficient than multiple processes. 

5. `ps ef` shows detailed info about processes and how they were started. 

6. To increase the priority of a process, add a negative nice value. These values can only go to -20 at their lowest. 

7. `renice 5 -p 1234` changes the priority for a currently running process with and id of 1234. 

8. mkill is not a command to send signals to processes. 

9. To change a priority from **top**, use **r** (for renice). 

10. To set the tuned performance profile, use `tuned-adm profile <profile>`. *Ex:* ` tuned-adm profile powersave`


### Review Questions

1. `jobs` command gives an overview of current shell jobs.

2. To stop the current shell job and move it to the baackground, type **ctrl + z** and then `bg`. It pauses the job then sends it to the background.

3. **ctrl + c** cancels the current shell job.

4. To cancel the job of another user for which you don't have the access to their shell, you can use `ps` to look for the PID then use `kill` with the PID use or `pkill` with the **-u** option and the process name.

5. `ps fax` shows parent-child relationships between processes.

6. To increase the priority of a current process, use `renice n -p PID`, where n is the number you want to set for priority.

7. `killall dd` will kill all dd processes.

8. To stop a command from running, you can use `pkill <command>`.

9. In `top`, use **k** to kill a process.

10. To select the best performance profile for your system needs, you need to use the **tuned** service.
