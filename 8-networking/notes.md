# Chapter 8 Notes: Networking 

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

Private