# Chapter 6: User and Group Management

**root user** - meant to perform system admin tasks

`id` shows details about the current user or a specified user
  - *Ex:* `id tandi`

`su` starts a subshell with another user identity in a terminal
  - you're able to work as the target user, but without the attached environment settings
  - use `su -` to work with the users environemnt settings
    - *Ex:* `su - rebecca`

`usermod -aG wheel username` makes a user part of the **wheel** group, which allows user to run all admin commands with sudo

`visudo` is used to edit the /etc/sudoers file which gives users access to specific sudo commands instead of all of them
  - *Ex:* `becca ALL-/usr/bin/useradd` allows becca to run only the `useradd` command with sudo admin priviledges

To use pipes in a sudo command, use this format:
`sudo sh -c "cmd | cmd"`.

**UID** is a unique id for every user. It's numeric and decides what a user can do
  - UID 0 is for root user. It's unrestricted
  - UIDs 1-999 are for system accounts
  - UIDs 100 and up are for regular accounts

**GID** is the primary group id. Each user has to be part of at least 1 group. Important for permissions.

*/etc/shadow* stores encrypted passwords and account security details. Readable only by the root user.

`userdel` removes a user.
  - `userdel -r` removes a user and the complete user environment

*/etc/skel* is the skeleton directory that is copied by default to the new user home directory, when creating a new user.

Set/change the default shell using **-s** in `useradd` or `usermod`. 
  *Ex:* `useradd banni -s /sbin/nologin`

`echo <password> | passed --stdin <user>` changes a users password to what is set in the **echo** stdout

`passwd <user>` changes user password without showing it in the command 

`usermod` modifies user properties and manages group membership. 

With the `useradd` command, default values are set in 2 config files: */etc/login.defs* and */etc/default/useradd*. 

*/etc/login.defs* file is used by many commands and sets up appropriate environment for the user. 
Properties that can be set from this file include:
  - MOTD_FILE: defines tbe file that should be used as the message of the day file 
  - ENV_PATH: defines path variables 
  - PASS_MAX_DAYS, PASS_MIN_DAYS, PASS_WARN_AGE: default oassword expiration properties 
  - UID_MIN: first uid to use when creating new users
  - CREATE_HOME: imdicates whether or not to create a home directory for new users

`chage` and `passwd` manages password properties. 

`passwd -n 30 -w 3 -x 90 tandi`:
  - **-n** minimal usage of 30 days
  - **-w** warning given 3 days before expiry 
  - **-x** set expiry after 90 days 

`chage -E 2025-12-31 tandi`:
  - **-E** sets expiry to specific date for passeord 

**User environment** - when a user logs in, an environment is created which consists of variables that determine how the user works. 
  *Ex:* $PATH variable 

*/etc/profile* is used for default aettings for all users when starting a login shell 

**Primary group** - every user is a primary group member 
  - a user can have only one primary group
  - user's primary group membership is defined in */etc/passwd*
  - the group is stored in */etc/group*

**Secondary group** - users can be a member of one or more secondary groups, in addition to their primary group. 

`groupadd` adds a group
  - *Ex:* `groupadd bannis`
  - **-g** specifies a group id when creating a group

`groupmod` manage group properties 
  - can also use `vigr` to edit the properties in */etc/group*

`lid` displays a users groups or a groups users 
  - *Ex:* `lid tandi` lists all grouosbthe user is in
  - *Ex:* `lid -g sales -l` lists all members pf the sales group 

`usermod -aG` adds users to groups which will be their secondary group(s) 

`groupmems` lists users who are members of a specified group 
  - *Ex:* `groupmems -g sales -l`


### Do you already know? Questions

1. To enhance system security in the root account, you should:
    - not set a eroot password. This disables the root account without deleting it. 
    - disable SSH login for the root user, so it can't be used on a remote server.

2. A user need to be part of the **wheel** group tp run all admin commands.

3. To allow user "amy" to change password for all users, except the root user, do this sudo config: `amy ALL=/usr/bin/passwd,!/usr/bin/passwd root`.

4. To use pipes in a sudo shell, the whole command should be executed as an argument to the `sh -c` command. *Ex:* `sudo sh -c "cat /etc/passwd | grep root"`.

5. For default settings when a new user is created, go to /etc/default/useradd. This only includes some settings; most user-related settings are in */etc/login.defs*.

6. To manage password properties, use `chage -l`.

7. When a user starts a login shell the following files are processed:
    - /etc/profile
    - ~/.bashrc
    - ~/.bash_profile

8. `vigr` creates a copy of /etc/group file so changes can be applied safely. It's the best option to modify group membership.

9. `id` and `group` commands can be used to list all groups a user is a member of. 

10. When */etc/nologin* exists, only a root user will be able to login.


### Review Questions 

1. The default parameter that can be changed to expand the lifetime of a sudo token is **timestamp_timeout**. It id set in the default config */etc/sudoers*. 

2. The config file where sudo is defined is in */etc/sudoers*.

3. To modify the sudo config file, use `visudo` or an editor to create sudo config files in */etc/sudoers.d*.

4. If there was an error and sudo doesn't work, assuming there is no password set for root, use `pkexec visudo` to run `visudo` without sudo privileges. 

5. 

6. Making a user part of the **wheel** group grants access to all admin commands through sudo. 

7. Use `vigr` to modify */etc/group* manually.

8. `passwd` and `chage` can be used to change password info. 

9. */etc/shadow* is where user passwords are stored. 

10. */etc/group* is where group account are stored. 


