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
