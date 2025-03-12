# Bash Shell Scripting

**shebang** - a line at the top of the script that tells the OS what kind of interpretor it should run on

### Conditionally execute code (use of: if, test, [], etc.)

Basic syntax:

```bash
if []
then
# commands
fi
```

`elif` means "else if"

case statement 
- blocks need to be finished with two semi colons 

`read` gets the user input. 





### Use Looping constructs (for, etc.) to process file, command line input

for loops

while loops
- break out of the loop with `break`
- finish with `done`



### Process script inputs ($1, $2, etc.)

Arguments are defined as **$1** - **$9**. It doesn't go past 9. 

**$@** refers to all of the arguments. 

**$#** is the total number of arguments.  

Take the output of a command:

`DIRLIST=$(ls -l ~)`

Don’t use hyphen/dash in variable names ??

Exit code processing: programs return an exit code that indicates if it was successful or not. 

**Exit code 0** indicates success. Other codes inidcate some type of failure. 

You can check an exit code with `echo $?`. 

The `exit` command at the end of the script causes it to end and return an exit code. *Ex:* `exit 0`. 



### Processing output of shell commands within a script

**>** redirecting to a file. Overwrites the file with new content.

**>>** redirect append to a file. Adds to the bottom of the file and doesn't overwrite the whole thing.

**2>** redirect error output to a file.

**2>&1** redirect both error and regular output to a file. Takes all eoor and output messages and sends them to the same place. 


example script
Output content to a another file with date stamp:
```bash
#!/bin/bash 

echo "hello" >> myscript-$(date + %Y%m%d-%H%M).log

exit
```

see if a network pinga:
```bash
#!/bin/bash 

ping -c $1

# capture the exit code of the above command
# if exit code is 0 pront the echo, else print the err msg echo 
if test "$?" -eq "0"
then
echo "$1 IP is reachable"
else 
echi "$1 IP is unreachable"
fi

exit
```

You need to add execute permissions to run your script like `chmod 754 file.sh`. 