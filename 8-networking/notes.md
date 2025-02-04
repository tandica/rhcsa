# Chapter 8: Networking 

**host** - a server providing services on the network 

**node** - devices that are connected to the internet 

Every IP address belongs to a specific network. A **router** allows for devices to communicate with each other. 

**Private network address**: for internal networks only
- naturally, nodes can't easily access the internet & the internet can't access the nodes 
- this is where *NAT* comes in
    - **NAT (Network Address Translation)**: connects private network to the internet 
        - nodes use private IPs, which are replaced with the IP address of the NAT router 
        - uses tables to keep track of all connections that currently exist 
        - allows multiple devices with private IPs to share 1 public ip for accessing the internet
- doesn't require a globally unique IP address
- not directly accessible from the internet

**Subnet mask**: defines which part of the network address indicates the network and which part indocates the node 
- can be written in CIDR (classlress inter-domain routing) notation or classical notation
  - CIDR *Ex:* 192.168.10.100/24
    - indicates a 24-bit network address is used
    - [192.168.10] is the network. [.100] is the hosthost
  - Classical *Ex:* 192.168.10.100/255.255.255.0
    - indicates the same as above 

In a network address, use a 4 bytet number. The **node address** is always set to 0. *Ex:* 192.168.10.0.

**Broadcast address** can be used to address all nodes in the network. All node bits are set to 1, which is equivalent to 255 (an entire byte). *Ex:* 192.168.10.255.

**MAC address** is on every network card as a 12-bit number. 
  - its used on the local network
  - *can't* be used for communication on nodes that are on different networks
  - helps computers find specific network card that an address belongs to
  - *Ex:* 00:0c:29:7d:9b:17
    - first 6 bytes: vendor id
    - second 6 bytes: unique node id
    - since vendor ids are registered, it's possible to have unique MAC addresses

**Port address**: each service running on nodes has a specific port address, like 80 for HTTP or 22 for SSH. In network communiaction, sender and reciever are using port addresses (s=destination port and source port).

**Class A Network**
1.0.0.0 - 126.0.0.0
- best for large organizations or ISP that have many hosts
- first 8 bits identify the network and remaining 24 bits identify host addresses
- hosts per network: 16 million
- *Ex:* 10.0.0.0/8 - a single class A network

**Class B Network**
128.0.0.0 - 191.255.0.0
- best for medium to large size network, like universities or enterprise organizations
- first 16 bits identify the network and the remaining 16 bits identify the host addresses
- hosts per network: 65 000
- *Ex:* 172.16.0.0/12 - 16 class B networks

**Class C Network**
192.0.0.0 - 223.255.255.0
- used for smaller networks, small businesses or departments
- first 24 bits represent network and last 8 bits represent host addresses
- hosts per network: 254
- *Ex:* 192.168.0.0/16 - 256 class C networks

**Protocol** happens between the IP address and the port address`
- *Ex:* TCP, UDP ICMP are examples of protocols
- **TCP** is used when network communication must be reliable and delivery must be guaranteed
- **UDP** is used when network communication must be fast and delivery is not guaranteed

**Network address** can be assigned in 2 ways:

1. fixed IP address. Usefule for servers and other computers that need to be available at the same IP address

2. dynamically assigned IP address. Useful for end users' devices and for instances in a cloud environment. Usually done using a DHCP server (Dynamic Host Configuration Protocol)

`ip addr` configures and monitors network address.

`ip route` configure and monitor routing info.

`ip link` configure and monitor link state.

`ip link set devicename26 up` sets the state to "Up" for devicename26 that is "Down".

`netstat` prints network connections, routing tables, interface stats, etc. It shows detailed info about network connections.

`ss` is the same as netstat, but newer and faster. 

**ifconfig** is NOT recommended to use. 

`ss -tul` lists all TCP and UDP ports that are listening on the server.

On RHEL9, networking is managed by the **NetworkManager**.

`systemctl status NetworkManager` checks the status of the network manager.

A **device** is a network interface card (NIC). 

A **connection** is the config used on a device.

Manage network connections with `nmtui` or `nmcli`, `nmtui` is faster to use, even though `nmcli` looks "cooler".

`nmcli general permissions` checks your current permissions.

** **Using `ip` to change something is temporary. Always use `nmtui` or `nmcli` to change something in the network that's meant to stay.**

`nmcli con show` shows all connections. After running this, you can append the name of the device to show more connection details. *Ex:* `nmcli con show ens160`.

`man 5 nm-settings` shows what each setting under a network connection means.

`nmtui` allows you to create network configurations easily. It has 3 options:

1. Edit a connection - create a new connection or edit one. After editing a connection, you must deactivate then reactivate it.

2. Activate a connection - can reactivate and deactivate connections here as well.

3. Set system hostname.

**hostname** is used to access servers and the services they offer. It consists of the name of the host abd the DNS domain where the host resides. It's also called *FQDN* and provides a unique identity on the internet. 

You can change the hostname 3 ways:

1. `nmtui` option for changing the hostname
2. `hostnamectl set hostname`
3. Edit config file */etc/hostname*

`getent hosts <servername>` verifies hostname resolution

### Do you already know? Questions

1. IP addresses 192.168.4.94/26, 192.168.4.97/26 and 192.168.4.120/26 all belong to the same network due to the /26 subnet.

2. 169.254.11.23 is not a private IP address.

3. p6p1, eth0, eno1677783 could all be network interface names. 

4. `ip addr show` displays info about network interface including IP addresses.

5. RHEL9 only works with **NetworkManager**.

6. `man nmcli-examples` has examples of `nmcli` usage.

7. `nmtui` is a text user interface to set and modify network connection properties.

8. To set a fixed IP address to a connection, use `nmcli con add con-name "static" ifname eth0 autoconnect no type ethernet 1p4 10.0.0.10/24 gw4 10.0.0.1`.

9. Do not edit */etc/resolv.conf* to specify which DNS servers to use as it will be overwritten when the NetworkManager is restarted. 

10. Set the hostname in the config file called */etc/hostname*.


### Review Questions

1. 213.214.215.96 is the network address in 213.214.215.99/2.

2. `ip link show` shows the link status.

3. If you manually edit the */etc/resolv.conf* file, your changes will be overwritten after restarting the NetworkManager. 

4. */etc/hostname* file contains the hostname.

5. `hostnamectl set hostname` sets the hostname.

6. The Network manager stores all connections in */etc/NetworkManager*.

7. To enable hostname resolution for a specific IP address, change the config file */etc/hosts*.

8. A user can change NetworkManager settings even if they're not an admin. It depends on the permissions that are set, which can be checked using `nmcli general permissions`. 

9. `systemctl status NetworkManager` verifies the current status of the NetworkManager.

10. `nmcli con mod "static" ipv4.addresses "10.0.0.20/24" 10.0.0.100` modifies current IP address and default gateway on the network connection.

