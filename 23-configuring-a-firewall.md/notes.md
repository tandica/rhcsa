# Chapter 23: Configuring a Firewall

A **Firewall** limits traffic coming in and out of a server. 

**Netfilter** allows kernel modules to inspect every incoming, outgoing or forwarded packets and either blocks or allows it.

iptables is an old way of interacting with netfilter. Not offered in new RHEL versions.

nftables is the new way of interacting with netfilter. 

**firewalld**
- system service that configures firewall rules by using different interfaces
- manages netfilter firewall config and firewall-cmd
- works with *zones*
- firewalld applies to incoming packets only, not outgoing packets

**zone**: a collection of rules that are applied to incoming packets matching a specific source address or network interface. Can have zones on servers that have multiple interfaces. You can assign rules to each zone.

<ins>Firewalld default zones:<ins/>

**block**
- incoming network connections are rejected with *icmp-host-prohibited* message
- only network connections that were initiated on this system are allowed.

**dmz**
- for computers in the demilitarized zone
- only selected incoming connections are accepted and limited access to the internal network in allowed

**drop** - any incoming packets are dropped and there is no reply

external
- for use on n=external networks with NAT (Network Address Translation) enabled
- only select incoming connections are accepted

**home**
- use with home networks
- most computers on the same network are trusted
- only selected incoming connections are accepted

**internal**
- use with internal networks
- most computers on the same network are trusted
- only selected incoming connections are accepted

**public**
- use in public areas
- other computers are not trusted and limited connections are accepted
- default zone for all newly created network interfaces

**trusted** - all network connections are accepted

**work**
- use in work areas
- most computers on the same network are trusted
- only selected incoming connections are accepted

---

<br />

**firewalld service**
- specifies what should be accepted as incoming and outgoing traffic in the firewall 
- can allow or deny access to specific ports
- comes down to adding the right services to the right zones

`firewall-cmd --getservices` lists all services.

`firewall-cmd --get-default-zone` gets the current default zone.

`firewall-cmd --get-zones` gets all available zones.

`firewall-cmd --list-services` lists all services in the current zone.

`firewall-cmd --set-default-zone=<ZONE>` changes default zone.

`firewall-cmd --add-service=<SERVICE> [--zone=<ZONE]` adds a service tot he default zone or the zone that's specified.

`firewall-cmd --remove-service=<SERVICE>` removes service.

`firewall-cmd --list-all-zones` shows config for all zones. 

`firewall-cmd --add-port=<PORT/protocol>` adds port and its protocol (*Ex:* 5234/tcp).

`firewall-cmd --remove-port=<PORT/protocol>` removes port.

`firewall-cmd --add-interface=<INTERFACE>` adds interface.

`firewall-cmd --remove-interface=<INTERFACE>` removes interface. 

`firewall-cmd --add-source=<IP/netmask> [--zone=<ZONE>]` adds a specific IP address.

`firewall-cmd --remove-source=<IP/netmask> [--zone=<ZONE>]` removes a specific IP address.

`firewall-cmd --runtime-to-permanent` adds current runtime config to the permanent config.

`firewall-cmd --reload` reloads the on-disk config to the permanent config.

<br />

### Do you already know? Questions

1. Standard firewall zones can include **Trusted**, **External** and **Internal**.

2. **Netfilter** is the firewall implementation in the linux kernel.

3. Firewalld is a management interface for **nftables**. 

4. Show all services available in firewalld with `firewall-cmd --get-services`.

5. **firewall-config** is the GUI tools you can use to manage firewalld configurations.

6. `firewall-cmd --add-port=2022/tcp --permanent` adds a port persistently to the current firewalld config. 

7. The trusted zone is for interfaces that need minimal protection because every computer on the network is trusted. 

8. To activate a config added with the **--permanent** option, you need to reload firewalld with `firewall-cmd --reload`.

9.  `firewall --list-all-zones` shows config for all zones. 

10. To write the current runtime config to the permanent config, use `firewall-cmd --runtime-to-permanent`.


### Review Questions

1. **firewalld** service should be running before trying to create a firewall config with firewall-config.

2. `firewall-cmd --add-port=2345/udp` adds UDP port 2345 to the firewall in the default zone.

3. `firewall-cmd --list-all-zones` lists all forewall configs in all zones.

4. `firewall-cmd --remove-service=vnc_server` removes the vnc_server from the current firewall config. 

5. `firewall-cmd --reload` activates a new config added with the **--permanent** option.

6. `firewall-cmd --list-all` allows you to verify a nerw config has been added and is active. 

7. `firewall-cmd --add-interface=eno1 --zone=public` adds the interface to the public zone.

8. If you add a new interface without specifying the zone, it will be added to the **default zone**. 

9. `firewall-cmd --add-source=192.168.0.0/24 --permanent` adds the source IP to the default zone. Firewalld must be reloaded afterwards with `firewall-cmd --reload`.

10. `firewall-cmd --get-services` lists all services currently available in firewalld.

