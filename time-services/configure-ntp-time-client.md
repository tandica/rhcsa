# Configuring an NTP time client
## Exercise 25-2

Configure the chronyd service to use a local time client instead of the public *pool 2.rhel.pool.ntp.org* using server1 and server2.

### Step 1: Make changes to server1.

Comment out the `pool 2.rhel.pool.ntp.org iburst` line in the chrony config file.

```bash
ssh tandi@server1.example.com 

sudo vim /etc/chrony.conf 
```

Comment the line like this:

```
# Please consider joining the pool (https://www.pool.ntp.org/join.html).
# pool 2.rhel.pool.ntp.org iburst
```

Add the a line in the same file that allows access to all clients that use a local IP address starting with ***192.168***.

```
# Allow NTP client access from local network.
allow 192.168.0.0/16
```

Add the following line as well, which ensures the local time server is going to advertise itself with a stratum of 8, meaning it will be used by clients only if no internet time servers are available.

```
local stratum 8
```

Restart the chronyd process.

```bash
sudo systemctl restart chronyd
```

Add the ntp service to the firewall config then reload it to open the firewall for time services.

```bash
sudo firewall-cmd --add-services=ntp --permanent

sudo firewall-cmd --reload
```

### Step 2: Configure server2. 

Diasble the same line in the chrony config file like the first step in #1:

```
# Please consider joining the pool (https://www.pool.ntp.org/join.html).
# pool 2.rhel.pool.ntp.org iburst
```

Add the following line to the same file:

```
server1.example.com
```

You can also use the ip address in place, if the name resolutuion is not configured.


Restart the chronyd process.

```bash
sudo systemctl restart chronyd
```

Type the following command to show that server1 and server2 have successfully synchronized their times.

```bash
chronyc sources
```


---