# Working with positional parameters
## Exercise 19-2


### Step 1: Create a script with arguments.

The arguments will be defined when you run the script. 


**1.1. Create a script file**

```bash
vim ex-19-2-a.sh
```

Add this to the script in the vim editor:

```bash
#!/bin/bash
#
# This script outputs arguments that are specified when it is run.

echo The first argument is $1
echo The second argument is $2
echo The third argument is $3

exit 0
```

Save the file and make it executable.

```bash
chmod +x ex-19-2-a.sh
```

### Step 2: Execute the script.

Add some arguments when executing the script.

```bash
./ex-19-2-a.sh a b c
# Output:

# The first argument is a
# The second argument is b
# The third argument is c
```

Try running the same script with more arguments.

```bash
./ex-19-2-a.sh a b c d e f 
# Output:

# The first argument is a
# The second argument is b
# The third argument is c
```

Even though we added more arguments, the output is the same.


### Step 3: Create a script that uses arguments in a flexible way.

**3.1. Create a script file**

```bash
vim ex-19-2-b.sh
```

Add this to the script in the vim editor:

```bash
#!/bin/bash
#
# This script outputs arguments in a flexible way when it is run.

echo you have entered $# arguments

for i in $@
do
	echo $i
done 

exit 0
```

Save the file and make it executable.

```bash
chmod +x ex-19-2-b.sh
```

### Step 4: Execute the script with and without arguments.

Run the script with arguments.

```bash
./ex-19-2-b.sh a b c d e f 
# Output:

# you have entered 5 arguments
# a
# b
# c
# d
# e
```

Run the script without any arguments.

```bash
./ex-19-2-b.sh
# Output:

# you have entered 0 arguments
```



---