# CSG Practice Exam

### 1. Interrupt the boot process and reset the root password. CHange it to "password" to gain access to the system.

1. Go to the GRUB2 menu and type `e` to edit

2. Go to the line that starts with "linux" and go all the way to the end of the line. Type `init=/bin/bash`.

3. Boot with "ctrl + x"

4. Remount the root partition as read/write with `mount -o remount,rw /`

5. Change the password for Root using `passwd`. 

6. Ensure the SELinux context types are correct by creating a autorelabel file with `touch /.autorelabel`.

7. Start the system with Systemd as PID (process id 1): `exec /usr/lib/systemd/systemd`

8. `reboot`

### 2. Add BaseOS and AppStream repos to the server.

`dnf config-manager --add-repo=https://link-to-baseos`

`dnf config-manager --add-repo=https://link-to-appstream`

You can run `dnf update` to ensure that everything is running.

### 3. Set the system time to your nearest timeone and ensure NTP sync is configured.

Get your timezone:

```bash
timedatectl list-timezones
```
Set the timezone:
```bash
timedatectl set-timezone America/Toronto
```

Configure NTP (turn it on):
```bash
timedatectl set-ntp 1
```

For NTP, ensure the **chronyd** service is installed. This service gets the time from the internet by default.

```bash
dnf install -y chronyd

systemctl enable --now chronyd

systemctl status chronyd
```

### 4. Add the following secondary IP addresses statically to your current running interface. Do this in a way that doesn't compromise your existing settings: 
#### a. IPV$ - 10.0.0.5/24
#### b. IPV6 - fd01::100/64

