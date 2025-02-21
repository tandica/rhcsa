# Chapter 19: Intro to Bash Shell Scripting

A **shell script** is a list of commands sequentially executed. 

**shebang: #/bin/bash** defines the script as a bash shell script. 

Add comments under the shebang to say what the script does. As it gets more complex, add commentd to the subsections. 

**exit 0** is used at the end of the script to terminate it and indicates that it's successfully completed to the parent shell. It’s not necessary to use for simple shell scrpts, but it's good practice. 

`chmod +x scriptname` adds execute permissionto the script to make it executable. You can also do `bash scriptname` to run a script without changing permissions. 

`./scriptname` runs the script. 

`clear` clears terminal screen before executing the rest of the script. 

The first argument of a script is $1, second is $2, and so on. 

$# - a counter that shows how many arguments were used when starting a script. 

$@ - refers to all arguments that were used when starting a script. 

**for loops**
- commands are executed as long as the condition is true
- the body of a for loop starts with **do** and is closed with **done**

**variable**
- label that refers to a specific value 
- can be defined statically like NAME=ella
- can be defined dynamically 2 ways:
    - using **read** to ask the user for input
    - use a command to assign the output to the value 

If loops - if, then, else, fi, elif
- **fi** is used to end the loop
- if an argument is true, commands after **then** are executed
- can use semicolon as separater instead of going on new line
- commonly used with the `test` commmand 

`test` checks file types and values. It can be used as an expression ([...]). *Ex:* `test -z $1` id the same as `[-z $1]`. 

Conditional loops

- if...then...else: used to execute code if a specific condition is true

- for: used to execute commands for a range of values 

- while: used to execute code as long as (while) a specific condition is true. Useful for monitoring the availability of a process - monitor it while its working

- until: used to execute code until a specific condition is true

- case: used to evaluate specific values, like a switch case. Close with **esac**. 

** `bash -x script.sh` use to debug a script. It shows line by line what the script is trying to do. Shows specific errors. 

<br />

### Do you already know? Questions

1. Every bash script should start with the shebang - **#!/bin/bash**. 

2. The purpose of **exit 0** used at the end of a script is to inform the parent shell that the script executed without any problems. 

3. To pause a script to allow a user to provide input, use **read**. 

4. Given the variable NAME, the first argument is stored in the line `NAME=$1`. 

5. To refer to all arguments thatvwere provided, use **$@**. **$*** also refers to all arguments, but groups them together as one entity. 

6. To close an if loop, use **fi**. 

7. If there is a nested if loop condition, it is started with **elif**. 

8. Within a for loop, use **do** to start the commands when the condition is true. 

9. To send a msg with the subject "error" to the root user, if something didn't work in a script, use `mail -s error root < .`. **-s** option specifies subject. **< .** is STDIN redirection. 

10. To refer to all options not specified in the script inside a case statement, use ** *)**. 


### Review Questions

1. If the script doesn't start with a **shebang**, it will be interpreted by the same shell as the parent shell. If you want to run it as a bash script, you need to add the shebang. 

2. To check if the variable VAR has no value, use `test -z $VAR` or `[-z $VAR]`. 

3. Use `$#` to count the number of arguments that have been used. 

4. Use `$@` to refer to all arguments that have been used. 

5. To process user input, use `read VARIABLE`. 

6. To test if a file exists and output an echo if it doesn't, use `[-f filename] || echo file doesn't exist`. 

7. To determine if something is a file or directory, use `[-e name]`. 

8. A **for loop** is used to evaluate a range of items. 

9. An `elif` statement is part of an if statement, which ends with `fi`. 

10. In a case statement, you have to use **;;** to close a specific item. 
