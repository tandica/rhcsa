# Using live log monitoring and logger
## Exercise 13-1

View real-time logs with 2 separate terminals

### Step 1: Show the current logs. 

Log in as root and show the last few lines of the /var/log/messages.

```bash
su - root

tail -f /var/log/messages
```

### Step 2: Open a second terminal and change to another user (student).

Type an incorrect password when logging into this user.

```bash
su - student
```

Notice that the first terminal logs this error: 

```bash
Nov 15 23:42:30 localhost su[5461]: FAILED SU (to student) tandi on pts/1
```

### Step 3: Open a second terminal and change to another user (student).

Login as student with the correct password and use the logger command to make a log entry.

```bash
su - student

logger hello hi
```

Notice the message appears in the first terminal: 

```bash
Nov 15 23:45:55 localhost student[5577]: hello hi
```

### Step 4: Observe authentication error logs

In the root terminal, stop tracing the log files and type the below command.

```bash
tail -20 /var/log/secure
```

Notice that the authentication error logs from using the wrong password are specified in this file. 

```bash
Nov 15 23:42:28 localhost unix_chkpwd[5470]: password check failed for user (student)
```

---