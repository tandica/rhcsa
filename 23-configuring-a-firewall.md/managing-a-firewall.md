# Managing the firewall with `firewall-cmd`
## Exercise 23-1


### Step 1: Explore `firewall-cmd`.

**1.1. Get the current zone of the firewall.**

```bash
su - root 

firewall-cmd --get-default-zone
# Output: 

# public
```

**1.2. Get all available zones.**

```bash
firewall-cmd --get-zones
# Output: 

# block dmz drop external home internal libvirt libvirt-routed nm-shared public trusted work
```

**1.3. Get all services available on the server.**

```bash
firewall-cmd --get-services
# Output: 

# RH-Satellite-6 RH-Satellite-6-capsule afp amanda-client amanda-k5-client amqp amqps apcupsd audit ausweisapp2 bacula bacula-client bareos-director bareos-filedaemon bareos-storage bb bgp bitcoin bitcoin-rpc bitcoin-testnet bitcoin-testnet-rpc bittorrent-lsd ceph ceph-exporter ceph-mon cfengine checkmk-agent cockpit collectd condor-collector cratedb ctdb dds dds-multicast dds-unicast dhcp dhcpv6 dhcpv6-client distcc dns dns-over-tls docker-registry docker-swarm dropbox-lansync elasticsearch etcd-client etcd-server finger foreman 
```

**1.4. List all services available in the current zone.**

```bash
firewall-cmd --list-services
# Output: 

# cockpit dhcpv6-client ssh
```

Since the current zone is public, only a limited number of services are enabled by default.

**1.5. Show an overview of the current firewall config.**

Both of these commands show the same overview of the firewall config.

```bash
firewall-cmd --list-all
# Output: 

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ssh
  # ports: 2022/tcp
  # protocols: 
  # forward: yes
  # masquerade: no
  # forward-ports: 
  # source-ports: 
  # icmp-blocks: 
  # rich rules: 
```

With the below command, you can check the config for specific zones by mentioning them. 

```bash
firewall-cmd --list-all --zone=public
# Output: 

# public (active)
#   target: default
#   icmp-block-inversion: no
#   interfaces: ens160
#   sources: 
#   services: cockpit dhcpv6-client ssh
#   ports: 2022/tcp
#   protocols: 
#   forward: yes
#   masquerade: no
#   forward-ports: 
#   source-ports: 
#   icmp-blocks: 
#   rich rules: 
```


### Step 2: Add a service to the firewall.

**1.1. Open VNC server access in the firewall.**

Add VNC server and verify its existence

```bash
firewall-cmd --add-service=vnc-server
# Output:

# success 

firewall-cmd --list-all
# Output:

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ssh vnc-server
  # ...
```

We can see that it's been added to the end of the *services* field.

**1.2. Add the same vnc-server, but make it permanent.**

Check that the service is not permanent. 

```bash
systemctl restart firewalld

firewall-cmd --list-all
# Output:

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ssh
  # ...
```

We can see that after restarting the *firewalld* service, the new `vnc-server` is no longer listed under the services field.

Add the vnc-server permanently.

```bash
firewall-cmd --add-service=vnc-server --permanent
# Output:

# success
```

Reload *firewalld* and verify that the service exists in the *services* field.

> Since we're making a change with rules (`--permanent`), we can just reload the service instead of using *systemctl* to restart it. It ensures that permanent config is applied to the runtime config, without having to service and connection interruptions.

```bash
firewall-cmd --reload

firewall-cmd --list-all
# Output:

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ssh vnc-server
  # ...
```


### Step 3: Add a port to the firewall.

Add a port.

```bash
firewall-cmd --add-port=2020/tcp --permanent
# Output:

# success


firewall-cmd --reload
# Output:

# success


firewall-cmd --list-all
# Output:

# public (active)
  # target: default
  # icmp-block-inversion: no
  # interfaces: ens160
  # sources: 
  # services: cockpit dhcpv6-client ssh vnc-server
  # ports: 2022/tcp 2020/tcp
  # ...
```

We can see that port 2020 has been added to the *ports* field.


---