# SELinux

## beanologi 

`semanage` - used to change SELinux context

default policy is targeted. 

Different apps define what is acceptable behaviour for the binaries n files used for that app. 

labels and context help define if there are issues with an application. 

it's a security layer that’s more comprehensive.  

enable selinux before setting permissive or enforcing. in /etc/selinux/config by setting SELINUX=enforcing. 

update /etc/default/grub in case any settings are set there for selinux. 

you must write the config file to apply the changes with `grub2-mkconfig -o /boot/grub2/grub/grub.cfg

after this, create the autorelabel file like ’touch /.autorelabel`. 

then, reboot the system. 

`getenforce` gets the selinux mode. 

`setenforce` sets the mode to enforcing or permissive. 

`ls -Z` shows selinux context label. 

**To restore default file context**:
- run `restorecon`
- Use **-Rv** options for recursive and verbose. 

set default file context:

** **`man semanage-fcontext` has the examples you need.** 

`semanage fcontext -l` lists the default file context settings for the current SELinux policy

`semanage port -l` lists all port type context settings currently in the policy

Make http be hosted on a non-standard port: 
- go into */etc/httpd/conf/httpd.conf* file
- change the `Listen` line to the desired port (ex: 4080)
- update the selinux context for the port: `semanage port -a -t http_port_t -p tcp 4080`

** **`man semanage-port` has examples you need.**

For booleans, use ** **`man semanage-boolean`**

`getsebool -a` lists all bolleans on the system. 

`semanage boolean -l` lists booleans on the system with details like the state, its default state and a description.

`setsebool http_enable_name 1` sets the boolean to on for http_enable_name.

`setsebool -P ftpd_anon_write on` also sets the boolean to on, but permanently, for ftpd_anon_write. 

<br>

## CSG

- SElinux defines access controls for the applications, processes and files on a system
- It uses secutiry policies which are rules that tell SELinux what can or cannot be accessed
- Prevents application from making chanegs on a system where it's not allowed to

`getenforce` gets the SELinux mode.

`sestatus` shows info about SELinux, including modes.

** SELinux logs are written to */var/log/audit/audit.log* and are tagges with **type=AVC**. To get these logs, you can do `grep AVC /var/log/audit/audit.log`.

`ls -Z` lists the security context of the files in that directory.

`ps -z` displays security context labels for running processes 

**Restore default file context:** `restorecon -R /dir/dir` restores file contexts recursivley. 

`getsebool -a | grep http` gets booleans for http service.

`setsebool -P http_ex_ample on` sets booleans permanently.

Get info for these commands: `info semanage`. 

To use `sealert`, install `dnf install setrouobleshoot-server`. 

`audit2allow -a -w` shows the error and a fix for SELinux 
