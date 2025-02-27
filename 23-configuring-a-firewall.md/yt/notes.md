# Firewall

## Beanologi

### Restrict network access using firewall-cmd/firewall

- Make sure firewall is enabled and active
- Remove uneeded ports and services
- Block an IP or network from connecting inbound
- Change default zone 
- Assign interfaces to zones
- Block ICMP traffic 

### Configure firewall settings with firewall-cmd/firewall

- use commands like --add-services, --change-interface, etc. to configure the firewall

Lab network

### Notes

`firewall-cmd --state` shows the state of firewalld.

If a firewall is masked and marked as not running, unmask it with `systemctl unmask firewalld`, then enable --now the firewalld service.

`firewall-cmd --get-active-zones` lists all active zones. A zone is "active" only if an interface is assigned to it. 

`firewall-cmd --list-ports` lists ports that are enabled. 

`firewall-cmd --remove-service={bitcoin,cockpit,telnet,smtp}` remives multiple services at once from a zone 

`firewall-cmd --remove-port={101/tcp,202/udp,303/tcp}` removes multiple ports 

The runtime config is the output you get when you run `firewall-cmd --list-all`. 

To make the changes from the above output permanent, use `firewall-cmd --runtime-to-permanent`. This command makes changes persistent. Run it after making changes if you dont use *--permanent* option*. You should reload the firewall after running this command. 

Block an incoming ip: `firewall-cmd --zone=block --add-source=10.0.0.13`. Makes all the traffic from the source address get handled by the block zone. 

Block an entire network by just adding the side notation to the ip address: `firewall-cmd --zone=block --add-source=10.0.0.0/24`. 

drop zone: completely ignores the traffic. Stricter than block. 

Part 2 video

Zone comparison

Low trust: block, drop, public

Med trust: dmz, external, internal

High trust: work, home, trusted

All zones except trusted have a way of rejecting traffic. *drop* just ignores the traffic.

Trusted accepts all inbound traffic. only direct traffic here if you trust it. 

All zones allow yiu to make outbound connections. To block certain websites, you need a to add to the "rich rule". 

nm-shared - a zone used internally for network connections

Only active zones have interfaces attached to them. If an interface is assigned to a non-default zone, it will be active and the default one will not be active if it has no interface assigned to it. 

When you remove an interface in a non-default zone, it becomes attached to the active default zone 

Use **--change-interface** to set the interface for a zone. --add-interface may not be as smart as the change option. 

You can use `nmcli` to change the interface of a zone:

`nmcli con mod "connection name" connection.zone public`

You can create custom zones. 

how to block icmp traffic: 

look at all the icmp types: `firewall-cmd --get-icmptypes`. 

choose the one you want to block: 
 
`firewallcmd --add-icmp-block=echo-request --permanent` 

 
`firewall-cmd --add-icmp-block-inversion --permanent` blocks all icmp traffic so that you can allow a few of them. All icmp traffic is allowed by drfault so if you block a few of them then run this inversion command, it will allow the few you initially blocked and block the rest. 


<br >

## CSG

### Restrict network access using firewall-cmd/firewall

`firewall-cmd --get-zones` lists all zones 

`firewall-cmd --new-zone=<new-zone> --permanent` creates a new zone. Must be used with the **--permanent** option.

`firewall-cmd --zone=<zone-name> --list-all` lists the details of a specific zone.

`firewall-cmd --change-interface=<interface>` adds interface to a zone.

`firewall-cmd --get-active-zones` lists active zones and their interfaces.

Get all services: `firewall-cmd --get-services`

### Configure firewall settings with firewall-cmd/firewall



<br >

## DexTutor

n/a
