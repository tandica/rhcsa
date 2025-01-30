# Chapter 7: Permissions

ugo owners:
- user
- group 
- others

`find / -user tandi` finds all files which are owned by user tandi. 

`find / -group sales` finds all files which are owned by group sales

`chown` changes ownership for files and directories. 
    - **chown who what**
    - *Ex:* `chown -R linda /dir` changes the owner of the /dir directory to linda
    - *Ex:* `chown lisa.sales myfile` or `chown lisa:sales myfile` sets lisa as user owner and sales as group owner. 
    - *Ex:* `chown .sales mylife` or `chown :sales myfile` sets group owner as sales without changing the user owner. 

`chgrp` changes group ownership. *Ex:* `chgrp sales /home/sales`

`newgrp` changes effective primary group. After its set, it opens a new shell where the temp primary group is set. This group will be used as the primary group until the user logs out or exits. The user has to be part of the group already for this to work, or else you can set a password using `gpassword`. 

`groups` shows all groups with primary one first. *Ex:* `groups lori`

**Read -> 4**
**Write -> 2**
**Execute -> 1**

**chmod absolute mode** displays numbers explicitly
    - *Ex:* `chmod 755 /file.txt‘

**chmod relative mode** displays group types added/subtracted to letters.  
    1. specify who to change pw for:
ugo owners:
    - user - u
    - group - g
    - others - o
    - all - a
You can elemintate this field if you want to apply the changes to all users: `chmod +x myfile.txt`
    2. Use an operator to add or remove (+ or -) permissions
    3. Use  r, w or x to specify read, write ior execute permissions. 
    - You can use more complex commands in recursive mode. *Ex:* `chmod g+w,o-r myfile` adds write permission for group and removes read permission for others. 

**Execute permission**
    - if you’re using recursion (-R), *always* use uppercase **X** so execute is applied to the subdirectories, but not the files. 
    - if you use lowercase **x** recursively, it can cause security issues with execute since all users will be able to see the files and execute them. 

**Advanced permissions*
1. **SUID**
    - Set user id 
    - useful for very specific situations, but dangerous 
    - if applied incorrectly, root permissions are given away
    - *Ex:* 

2. **SGID** 
    - Set group id
    - if applied on an executable file, it gives the user who executes the file the same permissions as the group owner
    - Does the same thing as SUID 
    - all files created to a directory oath with these permissions set will automatically have the specified group owner as the owner 
    - *Ex*!

3. **Sticky bit**
    - Protects files against accidental deletion when multiple users have write permissions in the same directory 
    - Users can inly delete files they own/created 
    - applied as the default to /tmp directory 
    - users can delete files only if they have root access, they own the file and thry own the directory the file is in
    - *Ex:*

To apply SUID, SGID and Sticky Bit, use `chmod`. 

There is absolute and relative mode but relative mode is safer. 


To set default missions, use ACLs or `umask`. 

**umask** works by automatically subtracting its value brom the 777 permissions setting. For example, if umask is 002, and the default permissions is 777,
the new permissions would be 755 (7-0,7-2,7-2). 

(defaultpermissions) - (umaskvalue) = new permissions 

**Attributes** are anothrr way to secure files. 
    - work regardless of which user acessesses the file. 


### Do you already know? Questions 

1. `newgrp` sets the effective primary group with affects default group ownership on new files until the shell session has ended. It's used when a user needs to work in a session where all new files they create need to be owned by a specific group. 

2. `find / -user linda` finds all files in a system that are owned by user linda. 

3. The correct format for `chgrp` command is `chgrp [group-name] [file/folder]`. 
    - *Ex:* `chgrp sales myfile`
    - You can also use the `chown` command to change groups. 
        - *Ex:* `chown .sales myfile` OR `chown :sales myfile`. 

4. `chmod 660` allows read/write permissions to user and group owners but nothing for anyone else. 

5. To apply execute permissions recursively, so that subdirectories but NOT their files are given these permissions, do:  `umask 444` then `chmod +X`. The large **X** allows for permissions to be granted to directories, but not their files. 

6. `chmod g+s /dir` adds SGID to directory /dir. 
`chmod g-s /dir` removes SGID from directory /dir.
`chmod u+s /dir` adds SUID to directory /dir.
`chmod 1770 /dir`sets sticky bit to directory /dir. 

7. The passwd program file needs execute permissions because it requires SUID permissions to be able to update the */etc/shadow* file. 

8. The root user has a different umask by default, due to the need of elevated permissions. 

9. 740 **come back**

10. `lsattr` checks the attributes of a file/directory. *Ex:* `lsattr myfile`. 





