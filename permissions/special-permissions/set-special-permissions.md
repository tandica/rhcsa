
# Setting Special Permissions
## Exercise 7-2
How to work with special permissions and test access control.

### Step 1: Switch to the "linda" user

Start from the **root** shell and switch to the **linda** user.

```bash
su - linda
```

Navigate to the `/data/sales` directory and create two files.

```bash
cd /data/sales
touch linda1 linda2
```

### Step 2: Switch to the "lori" user

Exit the **linda** user and switch to the **lori** user.

```bash
exit
su - lori
```

Navigate to `/data/sales` and list the files. You will see the files created by **linda** that are group-owned by that user.

```bash
cd /data/sales
ls -l
# Output: Files linda1 and linda2 created by linda:

# -rw-r--r--. 1 linda linda 0 Oct 21 07:35 linda1
# -rw-r--r--. 1 linda linda 0 Oct 21 07:35 linda2
# -rw-r--r--. 1 lori  lori  0 Oct 21 07:06 myfile
```

### Step 3: Remove linda’s files

Remove the files created by **linda**.

```bash
rm -f linda*
ls -l
# Output: Files removed:

# total 0
# -rw-r--r--. 1 lori lori 0 Oct 21 07:06 myfile
```

### Step 4: Create new files as "lori"

Create two new files as the **lori** user.

```bash
touch lori1 lori2
```

### Step 5: Escalate privileges

Escalate to **root** by typing the root password.

```bash
su -
```

### Step 6: Set SGID and sticky bit

Set the SGID (Set Group ID) and sticky bit on the `/data/sales` directory.

```bash
chmod g+s,o+t /data/sales/
```

### Step 7: Switch back to "linda" and create new files

Switch back to the **linda** user and create two new files.

```bash
su - linda
touch linda3 linda4
```

### Step 8: Check the group owner

List the files and notice the change in the group owner due to the SGID being set.

```bash
ls -l
# Output: Group owner changed for newly created files:

# -rw-r--r--. 1 linda sales 0 Oct 21 07:47 linda3
# -rw-r--r--. 1 linda sales 0 Oct 21 07:47 linda4
# -rw-r--r--. 1 lori  lori  0 Oct 21 07:41 lori1
# -rw-r--r--. 1 lori  lori  0 Oct 21 07:41 lori2
# -rw-r--r--. 1 lori  lori  0 Oct 21 07:06 myfile
```

### Step 9: Try removing lori’s files

Attempt to remove the files created by **lori**.

```bash
rm -rd lori*
```

Since **linda** is the owner of the `/data/sales` directory, the deletion works even though the sticky bit is set. Normally, the sticky bit would prevent this unless the user is the file owner or directory owner.

Check that **linda** is the owner of that directory. cd into the data directory. 

```bash
cd ..

ls -l
# Output: 
# drwxrwx---. 2 linda account  6 Oct 21 07:03 account
# drwxrws--T. 2 linda sales   48 Oct 21 07:51 sales
```

You can see that **linda** is the user owner of the directory.

---

### Summary

- **linda** is able to remove **lori's** files due to being the directory owner, despite the sticky bit being set.
- SGID ensures files created in the directory inherit the group ownership.
- The sticky bit usually prevents users from deleting others' files unless they are the directory or file owner.
