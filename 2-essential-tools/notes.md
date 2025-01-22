# Chapter 2 - Essential Tools

`>` is used for redirecting output to a file. 
Ex: `node server.js > logs.txt` logs the output of the node command in logs.txt. 

`>>` is used for redirecting output to the end of a file, appending it to the bottom of already existing data. 

`2>` and `2>>` works the same way, but for only errors. 

`&>` and `&>>` works the same way, but for **both** output and error messages. 

**Heredocs** - allows multi line input for scripts. Must end with the same keyword. 
Ex: cat > story.txt <<WORD 
        Line 1...
        Line 2...
WORD>>

`echo` - quick text output or file manipulation
       - displays text passed in as an argument 
       - can add and append text to a file 

`file` - displays file type regardless of file extension


`tail` - outputs the last 10 lines of a file
       - can use `-n` option to specify # of lines

`head` - outputs the first 10 lines of a file 

**vim** - text editor
        - has 3 modes:
            - normal
            - editing - use "i" to insert it "a" to append. 
            - Ex - quitting mode. Enter it with esc + :wq to save and exit, :q to quit without saving, or :w to save without exiting. 

`mkdir -p` - creates a parent and child directory if the parent doesn't exist 

**File globbing** - using wildcard characters to to match file names or directory names 
- `*` matches all characters 
       - Ex: `ls *.txt` lists all files in the directory that have the .txt extension 
- `?` matches only 1 character
       - Ex: `ls file?.txt` lists file1.txt and file2.txt but not file10.txt since `?` only matches a single character. 
- `[]` matches 1 character from a set of characters in braces 
       - Ex: `ls file[1-7].txt` lists file1.txt to file7.txt 
- `{}` create a list of options to match 
       - Ex: `ls file{1,2,7}.txt` lists file1.txt, file2.txt and file7.txt 

`less` - view contents one screen at a time with backward movement. Used to page through longer files. 

`wc` - count number of lines, words and characters in a text file or input stream 

`stat` - prints details about files and file systems 

### File permissions 

File permissions include read, write and execute. 

Permissions are split into 3 groups:
- user/owner 
- group 
- others 

On a file, permissions will look like this: 
`-rw-rw-r--`. 

It is split based on which type of user has access to what. 

`-`: The beginning indicates what it is. `-` means it's a file. `-d` means it's a directory. 

`-rw-`: The first 3 characters are permissions for the user/owner of the file and directory. Here, the user/owner has permissions to read and write but not execute. 

`rw-`: The second set of characters are permissions for the group. In this example, the group has read and write access but not execute. 

`r--` the third set of permissions are for "others", meaning those who are not the user and not in the group. They may be part of other groups. Here, "others" only has read access. 

Another way to represent permissions through the command line is with numbers, such as 777. The three numbers represent the three groups. Each group can have a maximum of 7 as the total value of their permissions. Each type of permission has a different value. 

Read = 4

Write = 2 

Execute = 1 

You can add whatever type of permission a group has and that is equivalent to the number version of their permissions. For instance, the user and group in the previous example had these permissions: `rw-`, which means read and write. The numerical value of this is 6, since r + w = 4.

Default permissions for files is 666. Default permissions for directories is 777. 

`umask` - controls the default permissions set for newly created files and directories by masking certain permissions. It's commonly a value like 022, 002. 
- Using this we can change the default permissions for files from 666 to something else 
- Ex: With unmask of 022, permissions is 644. (6-0, 6-2, 6-2)=644. 
*unmask of 022* - owner has full permissions group and others can read and execute
*unmask of 022* - owner and group have full permissions and others can read and execute 
*unmask of 077* - owner has full permissions and user and group have none. 

`chmod +x file.txf` adds "x" permission to ugo (user, group, others) only if those users already had any permissions 

`chown` - change file ownsership 
- Ex: `chown tandi:tandi file.txt` changes both the user and group owner of the file. 

`chgrp` - change group ownership 
- Ex: `chgrp tandi file.txt`

**Hard link** - multiple references to the same file without duplicating data

**soft link/symbolic link/symlink** - shortcut to another file/directory 
- Ex: asg node_modules pointing to multiple repos 

`ln` - used to create links between files 

`newgrp` - add new user group 

`su - user` - switch user with a login shell. Starts in the users home directory

`tar` - archives and compresses fikes 
- **-czf** for gzip for faster compression

### Shell scripting

**For loop** - iterates and processes a list 

**While loop** - iterates while a condition is true or becomes false

`$?` - variable that can determine success or failure condition
- **0** means success, anything else is failure
- Ex: `ls /etc/hosts; echo $?` outputs 0 and `ls /etc/host; echo $?` outputs 2 (error) since the directory path is incorrect

`||` - second command only runs if the first command fails 
- Ex: `cd dir1 || mkdir dir1` creates the directory if it doesnt exist

**Shebang (#!)** - to be at the top of a script
- makes a script executable from the CLI, regardless of their location
- in the shebang, specify the interpretor (bin/bash, etc.)

Permission must be set on bash script files to execute them.
 - `chmod a+x` applies execute permission regardless of existing permissions 
 - ./bin is used to store executable files and scripts 

`|` - (pipe) used to run multiple commands at the same time
- commands are started in parallel
- Ex: `history | grep cat` 

`cmd --help` - shows how to use a command
- Ex: `cat --help`

`man` - gives detailed info on how to use a command. There are different sections in man for different info. 
  - 1 : executable programs or shell commands 
  - 5 : file formats and conventions 
  - 8 : sys admin commands 
  - `man -k` searches for topics related to a given keyword. Useful if you’re not sure of the exact command you need. 
       - *Ex:* `man -k zip` outputs possible commands for zipping files/directories 

### Env config files 

**/etc/profile** - generic file that is processed by all users on login 

**/etc/bashrc** - file that is processed when subshells are started 

**~/.bash_profile** - file where user-specific login shell variable can be defined 

**~/.bashrc** - user-specific file where subshell variables can be defined 

`mandb` - updates the man database and installs new pages if they exist 

`pinfo` - structured info & detailed explanations for commands. More detailed and easier to naviagte than `man`. test. 
