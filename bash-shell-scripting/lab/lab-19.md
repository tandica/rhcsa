# Lab 19

Lab on bash shell scripting.

#### 1. Write a script that works with arguments. If the argument one is used, the script should create a file named /tmp/one. If the argument two is used, the script should send a message containing the subject “two” to the root user.

**1.1. Create a script file**

```bash
vim lab-19.sh
```

**1.2. Write the logic specified**

```bash 
#!/bin/bash

if [ $1 == "one" ]; then
  # create a new file 
  touch /tmp/one
elif [ $2 == "two" ]; then
# send a message to the root user with subject "two"
  echo "Message:" | mail -s "two" root
else 
  # handle invalid arguments
  echo "Invalid arguments."
fi

exit 0
```

#### 2. Write a countdown script. The script should use one argument (and not more than one). This argument specifies the number of minutes to count down. It should start with that number of minutes and count down second by second, writing the text “there are nn seconds remaining” at every iteration. Use sleep to define the seconds. When there is no more time left, the script should echo “time is over” and quit.

**1.1. Create a script file**

```bash
vim lab-19-2.sh
```

**1.2. Write the logic specified**

```bash 
#!/bin/bash

  # convert minutes to seconds
total_seconds=$((60 * $1))

while [ $total_seconds -gt 0 ]
do
  echo “There are $total_seconds seconds remaining” 
  # pause between iterations for 1 second
  sleep 1
  # decrement the amount of seconds by one for each iteration
  total_seconds=$(( total_seconds - 1 ))
done

echo "Time is over!"

exit 0
```


---