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