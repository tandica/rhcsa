
# Setting Basic Permissions
## Exercise 7-1
How to set basic permissions, changing ownership, and testing access with different users.

### Step 1: Create the necessary directories

Run the following command to create the `/data/sales` and `/data/account` directories.

```bash
mkdir -p /data/sales /data/account
```

### Step 2: Change group ownership

Assuming the user **linda** has been created, run this command to change the group ownership of the directories:
- Change group ownership of `/data/account` to the `account` group.
- Change group ownership of `/data/sales` to the `sales` group.

```bash
chown linda:account /data/account/ && chown linda:sales /data/sales/
```

### Step 3: Set directory permissions

Change the permissions so that the **user** and **group** have full permissions (`rwx`), while **others** have no permissions:

```bash
chmod 770 /data/sales && chmod 770 /data/account
```

### Step 4: Test permissions with another user

#### Step 4.1: Switch to a different user (e.g., lori)

Switch to a different user - **lori**:

```bash
su - lori
```

#### Step 4.2: Test access to `/data/account`

Try to navigate to `/data/account`. Since **lori** is not in the `account` group, they should be denied access.

```bash
cd /data/account
# Output: Permission denied
```

#### Step 4.3: Test access to `/data/sales`

If **lori** is a member of the `sales` group, they should be able to access `/data/sales` and create files.

```bash
cd /data/sales
touch file
# Success: lori can create files because they is in the "sales" group
```

---

### Summary

- **lori** is denied access to `/data/account` because itis not in the `account` group.
- **lori** can access and create files in `/data/sales` because they is a member of the `sales` group.
