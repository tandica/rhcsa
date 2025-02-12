# Chapter 12: Scheduling Tasks

To schedule tasks, you can use:
- **systemd timer**: default solution to ensure specific tasks are started at specific times
- **cron**: legacy scheduler service; still supported and responsible for scheduling a few services
- **st**: used to schedule an occasional user job for future execution

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


### Review Questions