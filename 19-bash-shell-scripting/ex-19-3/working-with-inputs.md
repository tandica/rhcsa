# Working with inputs
## Exercise 19-3


### Step 1: Create a shell script file that reads user input as an argument

**1.1. Create a script file**
```bash
vim ex-19-3.sh
```

Add the following script:

```bash
#!/bin/bash
#
# This script uses user input as an argument

# The if statement checks if an argument was entered when the script was executed
# if not, it asks for input from the user
if [ -z $1 ]; then
	echo enter a name
	read NAME
#otherwise, it uses the argument that was given when the script was run
else
	NAME=$1
fi

echo you have entered the text $NAME 
exit 0
```

Save the file and make it executable.

```bash
chmod +x ex-19-3.sh
```


### Step 2: Execute the script with and without arguments.

Execute the script without arguments.

```bash
./ex-19-3.sh
# Output:

# enter a name
# tandi
# you have enetred the text tandi
```

Notice you are promted to enter an input.

Execute the script with arguments.

```bash
./ex-19-3.sh bubzi
# Output:

# you have enetred the text bubzi
```

In the script, the if statement checks if an argument exists. If not, get user input with `read` and assign that input to the `NAME` variable. If it does exist, assign that value to the `NAME` variable. This is why it doesn't ask for input if we specify an argument when running the script.


---