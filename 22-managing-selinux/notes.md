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

SELinux logs are written to */var/log/audit/audit.log*. 

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
    - **user** (_u): SELinux users differ from linux users 
    - **role** (_r): Specific SELinux users can be assigned permissions to specific SELinux roles 
    - **type** (_t): context type. 
        - set a context tyoe in 2 ways:
            - `semanage` main command to use for this purpose. Writes new context to the SELinux policy, from which it is applied to the file system
            - `chcon`: do not use!! used for specific cases. 

`dnf whatprovides semanage` finds any RPM needed

** You can find the **context-type** by looking at default context settings on already existing items. 

`ls -Z` shows context settings for directories. 

`man semanage-fcontext` gets info for this command. Type "/example" for examples. 

3 ways to find the context:
1. Look at the default environment 
2. Read the config files 
3. use `man -k _selinux` to find specific SELinux man pages 

`restorecon` applies and restores context type changes. 

To relabel a file system, you can do:
1. `restorecon -RV /`
2. Create a file with the name */.autorelabel* and restart the system. The file system will be automatically relabelled 
