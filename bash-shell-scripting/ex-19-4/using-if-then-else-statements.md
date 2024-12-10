# Using if...then...else statements
## Exercise 19-4


### Step 1: Create a script that checks if the argument is a file, directory or neither.

Create a script file.

```bash
vim ex-19-4.sh
```

Add this to the script in the vim editor:

```bash
#!/bin/bash
#
# This script checks if an argument is a file, directory, or neither.
# Run it with an argument.

if [ -f $1 ]
then
	echo "$1 is a file"
elif [ -d $1 ]
then
	echo "$1 is a directory"
else
	echo "I don't know what $1 is"
fi

exit 0
```

Save the file and make it executable.

```bash
chmod +x ex-19-4.sh

./hello-world.sh
# Output:

# hello world
```


### Step 2: Execute the script with different arguments.

Test with a file:

```bash
./ex-19-4.sh /etc/hosts
# Output:

# /etc/hosts is a file
```

Test with a directory:

```bash
./ex-19-4.sh /usr
# Output:

# /usr is a directory
```

Test with something that doesn't exist:

```bash
./ex-19-4.sh /usr
# Output:

# I don't know what /bubzi is 
```


---