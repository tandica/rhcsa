# Chapter 7: Permissions

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
7. The root user has a different umask by default, due to the need of elevated prison. 

8. 
