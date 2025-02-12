# Chapter 12: Scheduling Tasks

To schedule tasks, you can use:
- **systemd timer**: default solution to ensure specific tasks are started at specific times
- **cron**: legacy scheduler service; still supported and responsible for scheduling a few services
- **at**: used to schedule an occasional user job for future execution

#### Systemd timers 

- always used together with a .setvice file; has matching names
    - log.timer works with log.service
    - service unit defines **how** the service should be started
    - timer file defines **when** it should be started

**[Timer]** section in the timer unit file
- OnCalendar: when the timer should execute
- AccuracySec: a time window within which the timer should execute
- Persistent: allows the last execution time to be stored on a disk, so the next time, it executes exactly one day after 
- OnActiveSec: drfines a timer relative to the moment the timer is activated 
- OnBootSec: defines a timer relative to when the machine was booted 
- OnStartupSec: specifies a time when the service manager was started
- OnUnitActiveSec: defines a timer relative to when the unit that the timer activates was last active 

#### Cron

`crond` is the service which schedules tasks

It consists of 2 manjor components:
1. daemon crond: this daemon looks every minute to see if there is anything to do
2. cron config: the work to do is defined here. It consists of multiple files working together to provide the right info to the right service at the right time

**crond service** is started by default. It’s easy to manage because crond daemon looks every minute at its config to see if anything needs to be started. 

`systemctl status crond` checks status of crond service. Beginning of this output is the most important because it tells you if the cron service is loaded and enabled. 

**cron date and time fields*:
**minute, hour, day of month, month, day of week**
- *Ex:* 07-18**1-5 : every hour at the top of the hour, between 7am - 6pm on weekdays. 
- *Ex:* 0*/22125 : every 2 hours on the hour on December 2 and every friday in december. 

*/etc/crontab* is the main config file for cron. It ***cannot** be modified. 

Modify these methods instead of the main config:
- cronfiles in /etc/cron.d
- scripts in /etc/cron.hourly, cron.daily, cron.weekly, cron.monthly 
- files created with `crontab -e`

** chrck below commands , seems opposite 

`crontab -e` creates a user-specific cron job from the users account

`crontab -e -u username` creates a unser-specific job from a root account

Files in */var/spool/cron* should **never** be edited directly. 

**To add a cronjob, add a file to the */etc/cron.d* and ensure it follows the syntax of a typical cron job.**

**anacron service** takes care of starting the daily, hourly, weekly and monthly cron jobs. 

**IMPORTANT**: `man 5 crontab` shows all timing possibilities and constructions. 

`crontab -l` lists cron jobs for the current user account. 

You can limit which user can schedule cron jobs by adding or removing them from */etc/cron.allow* and */etc/cron.deny*, respectively. 
- both of these files **cannot** exist on the same system at the same time. 
- only root can use cron if neither exist. 

**atd service** is meant for jobs that onky beed to run once. 

`at 12:00` runs a job through the atd service. It can be anytime, even can use "noon". 

`atq` shows an overview of all the jobs scheduled (in queue). 

`atrm <job#>` remove a current job using its job number. 

To allow jobs to only run when the system load permits, use `atd -l 3.0`, for instance, to ensure no batch job is started when the systemload is higher than 3.0. 


### Do you already know? Questions

1. Systemd is the default solution for scheduling recurring jobs in RHEL9

2. To configure a timer to start at a specific time, use **OnCalendar** in the timer section of the timer unit file. *Ex:* OnCalendar=*-*-* 03:00:00 triggers a service everyday at 3am. 

3. To start a timer 1min after Systemd starts, use the option **OnStartupSec* to specify this. *Ex:* OnStartupSec=5min

4. To make a systemd user unit to be started 2mins after the user has logged in, use the option **OnStartupSec**. 

5. **Cron timing**: minute, hour, day of month, day of year, day of week. 
- *Ex:* 011**7 runs a cron job at 11am on Sunday, every Sunday. 
- *Ex:* 023*** runs a job every evening at 11pm. 

6. */5***1-5 runs a job every 5 mins from monday to friday. 

7. To create a cron job for a specific user, you can:
- log in as that user and type `crontab -e` and create the job in that editor 
- As root, type `crontab -e -u username` and create the job in the editor 

8. */etc/crontab* file should **not** be executed directly. 

9. To close the editor shell, use **ctrl + d**. 

10. `atq` allows you to see the current jobs scheduled for execution in queue. 


### Review Questions

1. A cronjob that needs to be executed once every 2 weeks can be customized like this in */etc/cron.d*, or  tied to a user account with `crontab -e -u user`. 

2. To configure a service to be started 5mins after the system has been started, use `systemctl edit service-name` to override the config file and add [ExecStartPre]=/bin/sleep 300. OR, In the timer file, under [Timer], add the "OnBootSec=5min" option. 

3. If you've set a timer for a systemd service, but it doesn't work, you should enable the timer and not the service. 
- `systemctl daemon-reload`
- `systemctl enable service-name.timer`
- `systemctl start service.name` timer`
- check status: `systemctl status service-name.timer`

4. To start a service every 7 hours, create a Systemd timer that uses the option OnUnitActive to specify how much time after activation of a service it should be started again. Under [Timer], put OnUnitActive=7h. 

5. To match a timer to a service, they should have the same name. *Ex:* my.service and my.timer. 

6. To schedule a cronjob for user lisa, use `crontab -e -u lisa`. 

7. To specify that user boris is not allowed to schedule cron jobs, add the username to the */etc/cron.deny*. 

8. To ensure a job is executed everyday, even if the server at execution time is temporarily unavailable, add the job to `/etc/anacron` and ensure the anacron service is operational. 

9. To schedule 'at' jobs, the atd service must be running. You can verify this by checking its status with `systemctl status atd`. 

10. To find out if any jobs are scheduled for execution, use `atq`. It lists the jobs in queue. 


