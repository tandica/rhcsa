# Chapter 25: Configuring Time Services

**RTS (Real Time Clock)**
- **hardware clock** that is read when a linux server boots
- clock that resides on the main card of a computer

**UTC (Coordinated Universal Time)**: worldwise standard time

System time is also called **software clock**. It's the time maintained by the OS.

**NTP (Network Time Protocol)**: method of maintaining system time provided through NTP servers on the internet.

<br>

stratum
- defines the reliability of an NTP time source
-lower stratum is more reliable
- internet time servers use stratum 1 or 2
- local time servers can use higher stratms

<br>

** If a server is already connected to the internet, you just have to switch on NTP with `timedatectl set-ntp 1`.

<br>

`date`
- manages local time
- shows current time in different formats
- sets current time with **-s** option
  - *Ex:* `date -s 16:03`

<br>

`hwclock`
- manages hardware clock
- **--systohc** option synchronizes current system time to the hardware clock (system time to hardware time)
- **--hctsys** option synchronizes hardware time to the system clock (current hardware to system time)

<br>

`timedatectl`
- manages all aspects of time
- shows detailed info about time with no options/arguments
- same output as "status" option with no options
- **status** shows curretn time settings
- **set-time [TIME]** sets the current time
- **set-timezone [ZONE]** sets current timezone
- **list-timezone** lists all time zones
- **set-local-rtc [0 | 1]** controls whether RTC (the hardware clock) is in local time
- **set-ntp [0 | 1]** controls whether NTP is enabled

<br>

In linux, time is usually communicated in UTC, but local time also needs to be set.

You can set local time with:
- `tzselect` - an interface where region and locale can be selected
- `timedatectl` **recommended** for setting time zone info

**chrony**
- service that gets the time from the internet by default
- can be configured to use local time services instead by modifying */etc/chrony.conf* (see Exercise 25-2)

<br>

### Do you already know? Questions

1. When a system is started, it initially gets the time from the **hardware clock**.

2. Hardware time is typically set to UTC, but can be configures to the current time. 

3. `timedatectl` is recommended to use to set the lcoal timezone.

4. **Atomic clocks** can be used as an accurate alternative to a normal hardware clock.

5. */etc/chrony.conf* config file contains the default list of NTP services that should be contacted. 

6. `date -s 21:30` sets the system time to 9:30 PM.

7. To translate epoch time to human time, put an **@** in front of the epoch time string like `date --date '@1420987'`

8. `hwclock --hctosys` sets the system time to the current hardware time.

9. `timedatectl` without any arguments gives a complete overview of current time settings on your server.

10. `chrony sources` can be used to verify that a time client that is running the chrony service has successfully synchronized. Shows all synchronization sources. 


### Review Questions

1. `date -s 16:24` sets the system time to 4:24 PM.

2. `hwclock --systohc` sets the hardware time to the current system time.

3. `date --d '@nnnn'` or `date --date '@nnnn'` shows epoch time as human time. 

4. `hwclock --hctosys` sets the system time to the hardware time. Synchronizes system clock with the hardware time.

5. The **chronyd** service is used to manage NTP time. 

6. `timedatectl set-ntp 1` enables you to use NTP time on your server.

7. */etc/chrony.conf* contains the list of NTP servers to be used. 

8. `timedatectl list-timezones` lists all timezones. 

9. `timedate set-timezone [ZONE]` sets the current timezone.

10. `timedatectl set-time [TIME]` sets the system time. 
