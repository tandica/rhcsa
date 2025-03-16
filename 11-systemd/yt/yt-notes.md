# YT

`renice` changes priority of a service , 

change the niceness value permanently by editing the srvice file: `systemctl edit hrtpd.service`

add it like:

```bash
[Service]
Nice=2
```

then reload the daemon and restart the service. 

Hostname resolution 
hostnames - a user friendly way to refer to ip addresses

A domain name can also be a host name if configured to be like that. 

DNS is configured in */etc/resolv.conf*. it wont be persistent if its edited manually. 


Booting to targets

`systemctl list-units --type=target` 

Targets that are useful and commonly used:
- graphical.target
- multi-user.target
- rescue.target
- emergency.target

`AllowIsolate=yes` option in unit file lets you boot into the target type. 

`systemctl set-default` sets default you want to boot into.

`systemctl get-default` shows the current target the system uses. 

**To boot into certain targets**, go to the GRUB menu and edit the line that starts with "linux". Add the line `system.unit=emergency.target` to boot into the emergency target mode.

`dracut` regenerates the initramfs. 

