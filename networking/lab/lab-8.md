
# Lab 8

Lab on networking.

#### 1. On server1.example.com, use nmtui and configure your primary network card to automatically get an IP address through DHCP. Also set a fixed IP address to 192.168.4.210. On server2, set the fixed IP address to 192.168.4.220.

ssh into server1:

`ssh server1.example.com`

`nmtui`

On the GUI: 
- Edit a Connection 
- Change IPv4 setting to the one which is desired
- Add the mentioned ip address 
- Go back and reactivate the connection 
- Exit the tool

exit server1: `exit`

ssh into server2:

`ssh server2.example.com`

`nmtui`

On the GUI: 
- Edit a Connection 
- Add the mentioned ip address 
- Go back and reactivate the connection 
- Exit the tool

#### 2. Make sure that from server1 you can ping server2, and vice versa.

ssh into server1:

`ssh server1.example.com`

```bash
ping server2.example.com
#Output 

# PING server2.example.com (192.168.1.101) 56(84) bytes of data.
# 64 bytes from server2.example.com (192.168.1.101): icmp_seq=1 ttl=64 time=0.062 ms
# 64 bytes from server2.example.com (192.168.1.101): icmp_seq=2 ttl=64 time=0.091 ms
# 64 bytes from server2.example.com (192.168.1.101): icmp_seq=3 ttl=64 time=0.050 ms
# 64 bytes from server2.example.com (192.168.1.101): icmp_seq=4 ttl=64 time=0.064 ms
```

`exit`

ssh into server2:

`ssh server2.example.com`

```bash
ping server1.example.com
#Output 

# PING server1.example.com (127.0.1.1) 56(84) bytes of data.
# 64 bytes from server1.example.com (127.0.1.1): icmp_seq=1 ttl=64 time=0.056 ms
# 64 bytes from server1.example.com (127.0.1.1): icmp_seq=2 ttl=64 time=0.069 ms
# 64 bytes from server1.example.com (127.0.1.1): icmp_seq=3 ttl=64 time=0.030 ms
# 64 bytes from server1.example.com (127.0.1.1): icmp_seq=4 ttl=64 time=0.131 ms
# 64 bytes from server1.example.com (127.0.1.1): icmp_seq=5 ttl=64 time=0.121 ms
```
