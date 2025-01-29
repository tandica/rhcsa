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