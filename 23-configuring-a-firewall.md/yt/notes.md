# Firewalls

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

<br >

## CSG



<br >

## DexTutor
