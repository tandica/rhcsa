# Chapter 22: Managing SELinux

**SELinux**
- the default security station for all settings
- is deep inside the kernel, so if you switch it off, you have to restart to apply changes. 

** At the end of the exam, ensure SELinux is working, fully enabled and protecting the server. 

Core elements 

**Policy**: rules that define which source has access to which target

**Source domain**: the thing trying to access a target domain. Typically a user or process. 

**Target domain**: the thing a source is trying to access. Typically a file or port. 

**Context**: security label used to categorize objects in SELinux. 

**Rule**: specific part of the policy that determines which source domain has which access permissions to whicb target domain. 

**Label** determines which source domain has access to which target domain. Also called "context label". 

SELinux can be in different modes:

**Enforcing mode**: SELinux is fully operationaland enforces all rules 

**Permissive mode**: SELinux activity is logged but no access is blocked. Good for troubleshooting to see if SELinux is the problem. Makes system temporarily insecure. 

** SELinux logs are written to */var/log/audit/audit.log* and are tagges with **type=AVC**. To get these logs, you can do `grep AVC /var/log/audit/audit.log`.

`setenforce` switches between permissive and enforcing mode. 
- `setenforce 0` temporarily puts SELinux in permissive mode 
- `setenforce 1` temporarily puts SELinux in enforcing mode 

`getenforce` gets the current SELinux mode when it's enabled. 

To change the default mode more persistently, write it to */etc/sysconfig/selinux*. 

`setstatus -v` shows detailed info about the current status of SELinux on a server. 

`sepolicy generate` allows apps to run in an environment where SELinux is enabled. 

**Context label** 
- defines the nature of the object
- SELinux rules are created to match context labels of source objects/domains to the context labels of target objects 
- has 3 parts:
    - **user (_u)**: SELinux users differ from linux users 
    - **role (_r)**: Specific SELinux users can be assigned permissions to specific SELinux roles 
    - **type (_t)**: context type. 
        - set a context tyoe in 2 ways:
            - `semanage` main command to use for this purpose. Writes new context to the SELinux policy, from which it is applied to the file system
            - `chcon`: do not use!! used for specific cases. 

`dnf whatprovides semanage` finds any RPM needed

** You can find the **context-type** by looking at default context settings on already existing items. 

`ls -Z` shows context settings for directories. 

`man semanage-fcontext` gets info for this command. Type "/example" for examples. 

**fcontext** manages file security contexts.

<br />

**3 ways to find the context:**
1. Look at the default environment 
2. Read the config files 
3. use `man -k _selinux` to find specific SELinux man pages 

`restorecon` applies and restores context type changes. 

<br />

To **relabel a file system**, you can do:
1. `restorecon -RV /`
2. Create a file with the name */.autorelabel* and restart the system. The file system will be automatically relabelled. This is a better option if you don't know if the current context labels are consistent with SELinux policy settings.

<br />

To set a port label: `semanage port -a -t http_port_t -p tcp 8008`
- this changes the port label to offer services on port 8008
- no need for restorecon, it works right away
- **-a** adds a new context rule
- **-t** assigns the type
- **-p** specifies port #

<br />

`getsebools -a`
- gets all SELinux booleans on your system
- use `grep` when searching for a specific service
    - *Ex:* `getsebools -a | grep ftp`

<br />

`semanage boolean -l`
- lists all SELinux booleans
- shows more info than `getsebools -a`
- shows current and defauly boolean settings

<br />

`setsebool`
- change a boolean
- *Ex:* `setsebool -P ftpd_anon_write on`
    - **-P** option is for permanent changes

`sealert` provides aimplified audit log messages. It needs to be installed, then restart to apply changes.

<br />

### Do you already know? Questions

1. To set linux in diabled mode, add `selinux=0` to the GRUB 2 kernel boot argument.

2. You can see the current SELinux mode with both `getenforece` and `sestatus`.

3. Context type is the most significant basic setting in the context label.

4. **-Z** options displays SEinux related info and can be used with many commands. *Ex:* `ls -Z`.

5. `semanage fcontext -a -t http_sys_content_t "/web(.*)?"` is used to set the directory for /web to http_sys_content_t. 

6. `restorecon -R -v /etc/selinux` ensures that a file has the appropriate SELinux context after moving it to another location.

7. If there's an error msg that the port is already defined, you should use `semanage port -m`.

8. To change a boolean to survive a reboot/be persistent, use `setsebool -P`.

9. SELinux log messages are logged in */var/log/audit/audit.log.* Find them by using `grep AVC /var/log/audit/audit.log`.

10. SELinux logs always contain **AVC**, so you need to search those letters with `grep` when you want to look for SELinux logs.


### Review Questions

1. To put SELinux in permissive mode, use `setenforce 0`.

2. To list all available booleans,use `getsebools -a` or `semanage boolean -l`.

3. If there are no service-specific SELinux man pages, install them with `dnf install selinux-policy-doc`.

4. To get easy to read SELinux log messages, install setroubleshoot-server like `dnf install -y setroubleshoot-server`, which contains **sealert**, which gives simplified msgs. 

5. To apply the http_sys_content_t type to the /web directory, use `semanage fcontext -a -t http_sys_content_t "/web(.*)?"`.

6. Never use `chcon`.

7. To disable SELinux, add **selinux=0** to the line that configures the kernel in */etc/default/grub*. Then, apply the changes with `grub2-mkconfig -o /boot/grub2/grub.cfg`.

8. SELinux logs are in */var/logs/audit/audit.log*.

9. To get info about context types for the FTP service, use `man -k _selinux | grep ftp`.

10. To test whether a service has SELinux issues or not, use the service in permissive mode with `setenforce 0`.
