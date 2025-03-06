# selinux

semanage - 

default policy is targeted. 

different apps define what is acceptable behaviour for the binaries n files used for that app. 

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

to restore default file context, run `restorecon`. Use **-Rv** options for recursive and verbose. 

set default file context:

`man semanage-fcontext` has the examples you need. 










































