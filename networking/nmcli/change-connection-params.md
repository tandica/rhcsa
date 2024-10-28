
# Changing connection parameters with nmcli
## Exercise 8-4
How to modify connection parameters with nmcli.

### Step 1: Prevent automatic connection for static 

Ensure the static connection (made in the previous exercise) cannot automatically connect.

```bash
nmcli con mod static connection.autoconnect no
```

### Step 2: Add DNS server to the static connection

Note that in the previous exercise, **ip4** was used when adding a network, but to modify it, **ipv4** is used.

```bash
nmcli con mod static ipv4.dns 10.0.0.10
```

### Step 3: Add another DNS server to the static connection

Use the **+** sign to add a second item to the same parameters, in this case, the ipv4.dns parameters.

```bash
nmcli con mod static +ipv4.dns 8.8.8.8
```

### Step 4: Change existing parameters 

Alter the existing ip address

```bash
nmcli con mod static ipv4.addresses 10.20.30.40/16
```

### Step 5: Add another ip address

```bash
nmcli con mod static +ipv4.addresses 10.0.0.100/24
```

### Step 4: Change existing parameters 

Alter the existing ip address

```bash
nmcli con mod static ipv4.addresses 10.20.30.40/16
```

### Step 5: Activate the connection

**Always** activate the connection after changing properties.

```bash
nmcli con up static
# Output: 

# Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/5)

```

---
