# Chapter 3: Essential File Management Tools Notes 

**Mount** - connection between a device and directory
- allows for flexible organization for Linux file system bc: 
    - makes running services not be slowed down by high activity in one area
    - mounting file shstems result in better security since different areas of the system have different security requirements 
    - if a file system has only one device, it can be hard to make storage space. 

Linux file systems are often organized in different systems like disk partitions and logical volume, then mounted into the file system. 

`df -Th` - shows available disk space and most of the system mounts 

**Absolute file name/path name** - complete path refermxe to a file or directory 
    - *Ex:* Users/Tandi/Docs/GH/file.txt

**Relative file name/path name** - path relevant to the current directory 
    - *Ex:* - GH/file.txt if you’re in the GH folder

`ls -lrt` - lists files/directories in reverse chronological order 
- **-t** sorts by modification time 
- **-r** sorts in reverse, newest files at the bottom

`ls -d` lists directories 

`ls -R` shows contents of current directory and all subdirectories 

`cp -R` copies a subdirectory and all its contents. **-R** means *recursive*. 

`cp -a` copy with *archive mode* to cooy permissions as well 

**3 ways to copy hidden files:**
- `cp /dir/.*/tmp/ .` copies all files in /dir that’s start with a period. Use **-R** if any errow. 
- `cp -a /dir/` copies entire dorectory to the current path. Creates a subdirectory w the same tmam 
- `cp -a cp -a /dir/` -  copies all filss to the current directory 

**Inode** : where linux stores administrative data about files like:
- permissions
- file owners 
- creation, access & modification date
- data block where file contents are stored

`ln` - create links 
- `ls -l` - reveals if a file is a link if the first character is an l 

`tar` - used for managing archives
- `tar -cvf`: create archive with verbose 
- `tar -rvf`: add a file to an archive
- `tar -uvf`: update existing archive
- `tar -xvf`: extract contents of an archive`
    - extracts in current directory, unless specified with **-C** option 
- tar is just an archive; it doesn't compress unless you put the options (**-czf** for gzip or **-cjf** for bzip)
    - *gzip* offers faster compression and decompression
    - *bzip* saves more space

## Linux File System Hierarchy 

**/** - root, where file system tree starts

**/boot** - contains all files and directories needed to boot the kernel

**/dev** - contains device files used for accessibg physical devices. Essential during a boot 

**/etc** - containes config files used ny programs and services on the server. Essential during boot. 

**/home** - local user home directory 

**/media; /mnt** - has directories used for mounting devices in the file system tree

**/opt** - used for optional packages that may be installed in the server 

**/proc** - proc file system structure gives access to kernel info

**/root** - home directory of the root user 

**/run** - has process and user-specific info created since the last boot 

**/srv** - used for data by services like NFS, FTP, HTTP

**/sys** - used as an interface to different hardware devices that are managed by the linux kernel and associated processes

**/tmp** - has temporary files that may be deleted without warning during the boot process 

**/usr** - contains subdirectories with program files, libraries for these files and documentation about them 

**/var** - contains files that may change in size dynamically, such as log files, mail boxes and spool files 


### Do you already know? Questions 

1. **/run** is the default location for temp files. More secure than /tmp because each process has its own env. 

2. **/var** stores files that may grow unexpectedly. 

3. Enhance security with these mount options: 
    - nodev: mount can't access device files 
    - noexec: executable files can't be startedfrom the mount
    - nosuid: denies SUID permissions 

4. `df -hT` shows mounted devices and amount of disk space currently in use. `df` shows file system dism space usage.  

5. `ls -alrt`: -a shows hidden files; -l shows long listing; -r reverts sorting, so new files are at the bottom; -t sorts on modification time. 

6. `cp -a /home/$USER .` copies files, including hidden, from this path into the current directory. 

7. `mv` lets you rename files. 

8. In hard links, there's no different between the first hard link and subsequent ones. Deleting tbe first one will not invalidate the ones created afterwards. 

9. `ln -s /home /tmp` creates symbolic link from /tmp to /home.

10. `tar -u` updates an existing tar archive. 


### Review Questions 

1. **/etc** contains config files. 

2. `ls -alt` displays current directory contents, with newest items listed first, including hidden files and long listing. 

3. `mv myfile yourfile` renames "myfile" to "yourfile". 

4. `rm -rf` removes directory and its contents 

5. `ln -s /tmp ~` creates a symbolic link in the home directory to /tmp directory. 

6. `cp /etc/[abc]* .` copies all files that start with a, b and c to the current directory. 

7. `ln -s /etc ~` links /etc to the home directory.  

8. `rm symlink` removed the symbolic link to a directory. 
    - *Ex:* `rm mylink` removed only the symbolic link to a directory, not the original file or didectory it points to. 

9. `tar -czvf /tmp/etchome.tgz /etc /home` creates a compressed archive of /etc and /home and writes it to /tmp/etchome.tgz. 

10. `tar -xvf /tmp/etchome.tgz -C /etc/passwd` extracts the /etc/passwd directory from the archive. 


