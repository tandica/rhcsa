# Running scheduled tasks with *cron*
## Exercise 12-2
How to run scheduled tasks with cron..

### Step 1: Open the crontab editor interface and add the below line.

`0 2 * * 1-5 logger message from root`

```bash
# Open the crontab editor, add above line and save the file
crontab -e
```


### Step 2: Add a script file *eachhour* in cron.hourly that contaians the below line.

`logger This message is written at $(date)`

```bash
cd /etc/cron.hourly

touch eachhour

vim eachhour 
# Add the above line in the vim editor 
```


### Step 3: Make the file executable.

```bash
chmod +x eachhour
```


### Step 4: Make an *eachhour* file in /etc/cron.d and add the below line to that file. 

`11 * * * * root logger This message is written from /etc/cron.d`

The purpose for having a file in this directory is it allows you to have more control over the cron job. Jobs in this directory are specifically managed by root or software packages. Also, the cron daemon typically checks this directory.  

```bash
cd /etc/cron.d

touch eachhour

vim eachhour 
# Add the above line in the vim editor 
```


### Step 5: Verify the cron operation.

In a few hours, verify that the cron job is running. For this, we search the logs for the word "written" which is included in the cron.d file. 

```bash
grep written /var/log/messages
# Output: 

# Nov 13 22:01:01 localhost root[8902]: This message is written at Wed 13 Nov 2024 10:01:01 PM EST
# Nov 13 22:11:01 localhost root[9056]: This message is written from /etc/cron.d
# Nov 14 21:01:01 localhost root[5923]: This message is written at Thu 14 Nov 2024 09:01:01 PM EST
```

---