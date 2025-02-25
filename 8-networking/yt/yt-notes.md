# Managing Networking

## Beanologi

### Configure IPv4 and IPv6 addresses

`nmcli` - cmd line for configuring networking

`nmtui` - text ui for configuring networking

`ip --color addr` shows network interfaces

`nmcli con show` shows network profiles which are in */etc/NetworkManager/system-connections*

`nmcli con del <ens3>` deletes network connection

`systemctl restart NetworkManager` restarts the network manager to apply changes

** `man nmcli-examples` shows examples of how to use `nmcli` command

### Configure host name resolution

<br >

*/etc/hosts*
- you can change the ip address that your machine resolves a name to
- *Ex:* you can specify example.org to resolve to the ip address 1.2.3.4
- you can test this by using `ping example.org` and you'll see that ip address in the output

<br >

*/etc/resolve.conf*
- where programs find the ip address for the dns server
- has to be modified by **NetworkManager**

### Configure network services to start automatically at boot

The httpd service automatically starts when the network is ready, so no changes need to be made. 

`systemctl edit httpd.service` shows the unit file for this service.

** Under [Unit], there should be this option **After=network.target** which ensures the service is started after the network is up. 

### Restrict network access using firewall-cmd/firewall

Use firewalld commands to remove services:

`firewall-cmd --permanent --remove-service ssh`

You must reload the firewalld service after using the permanent option to apply changes:

`firewall-cmd --reload`

<br >

## CSG

### Configure IPv4 and IPv6 addresses

You have a public ip address which you can use to access the internet and a private ip sddress you use in your own network. 

**CIRDR (Classless Inter Domain Routing)** uses a subnet mask

**Subnet mask** is like a block that llimits the network. 

**Gateway** - a router

### Configure host name resolution

Hostname - a name for your device/host. You have a hostname and an ip address. 

You can use DNS to rseolve your hostname to an ip address. 

`hostname -s` shows hostname of the machine. You

*/etc/hostname* - file that stores the hostname

`hostnamectl` shows host name and machine info.  

DNS is configured by nmcli 

*/etc/resolv.conf* has the configuration of DNS. In this file, the nameserver fields are used to get DNS resolution. **Modify this if the question requires configuring a system to use an external DNS server.**

Modify this file with `nmcli` or network manager

`nmcli connection modify ens ipv4.dns "8.8.8.8"` adds 8.8.8.8 to the DNS configuration. You can add an ip address to configure it. 

You can also modify */etc/hosts* to resolve DNS by adding the ip and name. **Modify this if the question requires you to resolve a hostname without configuring a DNS server. It is for local hostname to ip mapping.**


### Configure network services to start automatically at boot

`systemctl enable servicename` enables a service at boot.

`systemctl disbale servicename` disables a service from starting at boot.

Enable network card to start on boot: `nmcli connection modify eth0 connection.autoconnect yes`


### Restrict network access using firewall-cmd/firewall

Create a new firewall zone: `firewall-cmd --permanent --new-zone <ZONE>`

Assign specific services to a zone: `firewall-cmd --zone <ZONE> --add-service=ssh --permanent`

`fireall-cmd --zone <ZONE> --list-all` shows info about the zone and verifies if a service has been added. 

`firewall-cmd --add-interface=<INTERFACE>`

<br >

## DexTutor

network mask - 255.255.255.0

Each 255 means 8 bits. Since there are 3 here, then its 8+8+8=24. 24 is adde to the end of the IP address like this **192.168.5.3/24**.

`ip addr show` shows you network info.

`nmcli con add` creates a new connection

`nmcli con mod` modifies a connection

Set a hostname:

```bash
nmcli general hostname server.example.com
hostnamectl set-hostname server.example.com
```

Practice Questions**