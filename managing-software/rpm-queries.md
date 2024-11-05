
# Using RPM queries
## Exercise 9-3
Practice using RPM queries.

### Step 1: Install a package

Install a package and verify the pathname.

```bash
dnf install -y dnsmasq
which dnsmasq
# Output:

# /usr/sbin/dnsmasq
```

### Step 2: Do an RPM query

The following command does a file query on the result of **which dnsmasq**. 
It shows that it comes from the dnsmasq package. 

```bash
rpm -qf$(which dnsmasq)
# Output:

# dnsmasq-2.85-16.el9_4.x86_64
```

### Step 3: Find out more info about the given package 

```bash
rpm -qi dnsmasq
# Output: 

# Name        : dnsmasq
# Version     : 2.85
# Release     : 16.el9_4
# Architecture: x86_64
# Install Date: Tue 05 Nov 2024 04:22:33 PM
# Group       : Unspecified
# Size        : 718710
# License     : GPLv2 or GPLv3
# Signature   : RSA/SHA256, Fri 15 Mar 2024 10:50:46 AM
# Source RPM  : dnsmasq-2.85-16.el9_4.src.rpm
# Build Date  : Fri 15 Mar 2024 09:04:00 AM
# Build Host  : x86-vm-14.build.eng.bos.redhat.com
# Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
# Vendor      : Red Hat, Inc.
# URL         : http://www.thekelleys.org.uk/dnsmasq/
# Summary     : A lightweight DHCP/caching DNS server
# Description : ...
```

### Step 4: List all the files in the package

```bash
rpm -ql dnsmasq
# Output:

# /etc/dbus-1/system.d/dnsmasq.conf
# /etc/dnsmasq.conf
# /etc/dnsmasq.d
# /usr/lib/.build-id
# /usr/lib/.build-id/00
# /usr/lib/.build-id/00/0be6c4c54d040738da4bc45b14db83341ea2dc
# /usr/lib/systemd/system/dnsmasq.service
# /usr/lib/sysusers.d/dnsmasq.conf
# /usr/sbin/dnsmasq
# /usr/share/dnsmasq
# /usr/share/dnsmasq/trust-anchors.conf
# /usr/share/doc/dnsmasq
# /usr/share/doc/dnsmasq/CHANGELOG
# /usr/share/doc/dnsmasq/DBus-interface
# /usr/share/doc/dnsmasq/FAQ
# /usr/share/doc/dnsmasq/doc.html
# /usr/share/doc/dnsmasq/setup.html
# /usr/share/licenses/dnsmasq
# /usr/share/licenses/dnsmasq/COPYING
# /usr/share/licenses/dnsmasq/COPYING-v3
# /usr/share/man/man8/dnsmasq.8.gz
# /var/lib/dnsmasq
```

### Step 5: Show the documentation in the package

```bash
rpm -qd dnsmasq
# Output:

# /usr/share/doc/dnsmasq/CHANGELOG
# /usr/share/doc/dnsmasq/DBus-interface
# /usr/share/doc/dnsmasq/FAQ
# /usr/share/doc/dnsmasq/doc.html
# /usr/share/doc/dnsmasq/setup.html
# /usr/share/man/man8/dnsmasq.8.gz
```

All these files have documentation steps for this package.
You can copy and paste the URL to the browser to see the contents.

### Step 6: Show config files

```bash
rpm -qc dnsmasq
# Output:

# /etc/dbus-1/system.d/dnsmasq.conf
# /etc/dnsmasq.conf
```

### Step 7: Show scripts

Show scripts that are executed when the package is installed. Best to do this before installing the package. 

```bash
rpm -q --scripts dnsmasq
# Output:

# preinstall scriptlet (using /bin/sh):
#precreate users so that rpm can install files owned by that user

# generated from dnsmasq-systemd-sysusers.conf
# getent group 'dnsmasq' >/dev/null || groupadd -r 'dnsmasq' || :
# getent passwd 'dnsmasq' >/dev/null || \
#     useradd -r -g 'dnsmasq' -d '/var/lib/dnsmasq' -s '/usr/sbin/nologin' -c 'Dnsmasq DHCP and DNS server' 'dnsmasq' || :
# postinstall scriptlet (using /bin/sh):

 
# if [ $1 -eq 1 ] && [ -x "/usr/lib/systemd/systemd-update-helper" ]; then 
#     # Initial installation 
#     /usr/lib/systemd/systemd-update-helper install-system-units dnsmasq.service || : 
# fi
# preuninstall scriptlet (using /bin/sh):

 
# if [ $1 -eq 0 ] && [ -x "/usr/lib/systemd/systemd-update-helper" ]; then 
#     # Package removal, not upgrade 
#     /usr/lib/systemd/systemd-update-helper remove-system-units dnsmasq.service || : 
# fi
# postuninstall scriptlet (using /bin/sh):

 
# if [ $1 -ge 1 ] && [ -x "/usr/lib/systemd/systemd-update-helper" ]; then 
#     # Package upgrade, not uninstall 
#     /usr/lib/systemd/systemd-update-helper mark-restart-system-units dnsmasq.service || : 
# fi
```
---

