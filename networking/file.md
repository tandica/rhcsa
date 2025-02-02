# Chapter 8 Notes: Networking 

**host** - a server providing services on the network 

**node** - devices that are connected to the internet 

Every IP address belongs to a specific network. A **router** allows for devices to communicate with each other. 

**Private network address** - for internal networks only
- naturally, nodes can't easily access the internet & the internet can't access the nodes 
- this is where *NAT* comes in
    - **NAT (Network Address Translation)**: connects private network to the internet 
        - nodes use private IPs, which are replaced with the IP address of the NAT router 
        - uses tables to keep track of all connections that currently exist 

**Subnet mask**: defines which part of the network address indicates the network and which part indocates the node 