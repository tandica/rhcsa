# Writing a simple shell script
## Exercise 19-1


### Step 1: Create a simple shell script

Create a script that outputs the message "hello world".

**1.1. Create a script file**

```bash
vim hello-world.sh
```

Add this to the script in the vim editor:

```bash
#!/bin/bash
#
# This script greets the world

clear
echo hello world

exit 0
```

Save the file.


### Step 2: Execute the script.

Try executing the script.

```bash
./hello-world.sh
# Output:

# -bash: ./hello-world.sh: Permission denied
```

You get an error because the file is not yet executable. Change the permissions and try executing again.

```bash
chmod +x hello-world.sh

./hello-world.sh
# Output:

# hello world
```

It works now.

---