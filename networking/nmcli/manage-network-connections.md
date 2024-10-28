
# Managing network connections with nmcli
## Exercise 8-3
How to create a new network connection and manage its status.

### Step 1: Create a new network connection

Run the following command to add the ens33 device.

```bash
nmcli con add con-name dhcp type ethernet ifname ens160 ipv4.method auto
# Output:

# Connection 'dhcp' (67892383-6396-464e-bfbd-64705f5f3642) successfully added.
```

### Step 2: Create a connections with static ip address and gateway

```bash
nmcli con add con-name static ifname ens160 autoconnect no type ethernet ip4 10.0.0.10/24 gw4 10.0.0.1 ipv4.method manual
# Output:

# Connection 'static' (9f1c0288-65a3-47f6-80f5-448009df983b) successfully added.
```

### Step 3: Activate static connection

Show the connections, then activate the static connection.

```bash
nmcli con show
# Output: 

# NAME    UUID                                  TYPE      DEVICE 
# ens160  2e7964d9-946f-38fd-abd8-085c8f972558  ethernet  ens160 
# lo      85bc2900-0866-42ba-bada-cfd1352e29c0  loopback  lo     
# dhcp    67892383-6396-464e-bfbd-64705f5f3642  ethernet  --     
# static  9f1c0288-65a3-47f6-80f5-448009df983b  ethernet  --  

nmcli con up static 
# Output: 

# Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/3)
```

### Step 4: Switch back to DHCP connection

```bash
nmcli con up dhcp
# Output:

# Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/4)
```

---
