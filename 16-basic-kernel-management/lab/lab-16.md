
# Lab 16.1

Lab on basic kernel management.

#### 1. Find out whether a new version of the kernel is available. If so, install it and reboot your computer so that it is used.

Check the current kernel version.

```bash
uname -r
# Output:

# 5.14.0-503.14.1.el9_5.x86_64
```

Check for updates as a root user.

```bash
su - root

dnf check-update kernel
# Output:

# kernel.x86_64                        5.14.0-503.15.1.el9_5                rhel-9-for-x86_64-baseos-rpms
```

Since there's a new version available, let's update the kernel.

```bash
dnf -y install kernel
```

Check that the kernel version has updated.

```bash
reboot

uname -r
# Output:

# 5.14.0-503.15.1.el9_5.x86_64
```


#### 2. Use the appropriate command to show recent events that have been logged by the kernel.


```bash
dsmeg
# Output:

#  [    0.000000] Linux version 5.14.0-503.15.1.el9_5.x86_64 (mockbuild@x86-64-03.build.eng.rdu2.redhat.com) (gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-2), GNU ld version 2.35.2-54.el9) #1 SMP PREEMPT_DYNAMIC Thu Nov 14 15:45:31 EST 2024
# [    0.000000] The list of certified hardware and cloud instances for Red Hat Enterprise Linux 9 can be viewed at the Red Hat Ecosystem Catalog, https://catalog.redhat.com.
# ...
```

#### 3. Locate the kernel module that is used by your network card. Find out whether it has options. Try loading one of these kernel module options manually; if that succeeds, take the required measures to load this option persistently.

**3.1. Find the bus id of the network card**

The *bus id* helps to identify the location of a device on a systema and enables the kernel to mp the correct driver to the device.

> The **-nn** option shows numeric PCI IDs for the device.

```bash
lspci -nn
# Output:

# ...
# 03:00.0 Ethernet controller [0200]: VMware VMXNET3 Ethernet Controller [15ad:07b0] (rev 01)
# ...
```

Find the kernel module being used by that *bus id*.

```bash
lspci -k -s 03:00.0
# Output:

# 03:00.0 Ethernet controller: VMware VMXNET3 Ethernet Controller (rev 01)
	# DeviceName: Ethernet0
	# Subsystem: VMware VMXNET3 Ethernet Controller
	# Kernel driver in use: vmxnet3
	# Kernel modules: vmxnet3
```

> The **-k** option shows kernel modules and the **-s** option allows you to search by the *bus id*.


Check if it has options.

```bash
modinfo vmxnet3
# Output:

# filename:       /lib/modules/5.14.0-503.15.1.el9_5.x86_64/kernel/drivers/net/vmxnet3/vmxnet3.ko.xz
# version:        1.9.0.0-k
# license:        GPL v2
# description:    VMware vmxnet3 virtual NIC driver
# author:         VMware, Inc.
# rhelversion:    9.5
# srcversion:     AF3203509D366EF525247DF
# alias:          pci:v000015ADd000007B0sv*sd*bc*sc*i*
# depends:        
# retpoline:      Y
# intree:         Y
# name:           vmxnet3
# vermagic:       5.14.0-503.15.1.el9_5.x86_64 SMP preempt mod_unload modversions 
# sig_id:         PKCS#7
# signer:         Red Hat Enterprise Linux kernel signing key
# sig_key:        7D:0D:00:56:8D:46:CC:BD:36:9A:82:9C:05:C4:FB:48:45:3E:DA:80
# sig_hashalgo:   sha256
# signature:      91:1D:F1:20:93:08:3A:3C:F1:83:67:A4:DF:56:C6:1E:83:29:4F:A5:
# 		86:63:71:D2:8C:87:34:99:49:99:95:E4:A0:0A:99:F8:DF:2F:86:E4:
# 		D8:DB:C4:B9:8C:D4:CA:C0:DF:B5:ED:03:8D:6C:D4:D0:0C:2B:C0:BC:
# 		C9:C6:7A:ED:9D:2D:E8:21:09:27:C3:45:FC:C4:36:24:F1:4C:80:4E:
# 		37:1D:7A:01:50:23:E3:9F:8B:66:9F:29:7C:35:82:F5:A2:05:82:8C:
# 		93:78:F8:6A:39:4E:BF:20:21:91:DA:8A:88:36:4B:08:0D:55:5F:2B:
# 		ED:05:5C:79:E9:D5:52:21:D4:91:3D:61:B5:42:83:45:9C:12:DD:24:
# 		70:4E:BC:F9:F3:F8:E9:98:CA:A4:49:AB:5C:0A:28:DA:8B:0B:8A:F6:
# 		D9:11:EF:F8:9C:C4:4B:C7:3B:2E:54:26:A6:C4:0C:FC:D1:EA:D1:2A:
# 		F7:00:E8:2B:CD:BE:EA:04:61:AE:33:EB:B9:E2:EB:F9:69:40:C3:C2:
# 		F2:6E:98:E2:7C:B7:BD:8F:73:B0:06:A6:5D:FA:A5:09:12:2E:D3:76:
# 		D3:EA:6F:92:1B:57:64:49:7B:E1:49:EA:09:52:47:DA:EE:FB:E7:7E:
# 		25:26:EE:14:90:99:B9:F5:03:5C:9E:3B:AD:3F:4C:C3:6F:22:EC:D0:
# 		96:D8:F6:4F:CA:E9:C9:DE:65:F7:71:20:1E:11:59:49:9C:F8:C6:0F:
# 		FD:90:17:45:47:F9:4A:1F:F1:6B:AB:38:F6:9C:DC:48:39:92:69:9B:
# 		2B:22:B2:B8:D4:E6:25:AC:67:FE:80:0D:FE:4B:E2:86:84:DC:A9:96:
# 		C7:9B:96:EF:EE:BA:DE:6F:C8:BC:5A:26:5F:A0:1C:56:22:52:31:55:
# 		8E:53:24:1C:7F:64:1A:11:93:61:7D:05:B2:6D:BF:F3:B0:17:D3:B7:
# 		2F:87:3A:58:56:9F:9D:2F:3F:FF:31:C6:7A:87:32:AB:F0:5B:40:7B:
# 		A8:19:F6:EA
```

Since there are no *parm:* fields, this kernel module has no options and I can't proceed with the next steps.


---