# Chapter 5: Connecting to RHEL9

`chvt` - switch terminals 1-6 in a non-graphical environment
  - *Ex:* `chvt 5` goes to tty5

**ctrl + alt + F1** - access non-graphical (virtual) terminal
  - use F1-F6 for desired terminal

**Virtual terminals** are non-graphical. They're referred to devices /dev/tty1 - /dev/tty6.

**Pseudo terminals** are graphical. They're referred to as /dev/pts/1 and so on.

A server reboot is necessary to:
  - recover from serious problems like server hangs and kernel panics
  - apply kernel updates
  - apply changes to kernel modules that are currrently used and not reloaded easily

A reboot must be done properly, otherwise data will be lost because processes that have data don't write it directly to the disk, they store it in memory buffers (cache).

To do a proper reboot, you need to **alert the Systemd process**.

**Systemd:** 
- first process to start when the server starts
- responsible for all other processes
- ensures all processes are stopped before a reboot

To tell Systemd to stop the processes, you can:
- `systemctl reboot` or `reboot`
- `systemctl halt` or `halt`
- `systemctl poweroff` or `poweroff`

`ssh`:
- connects to remote host
- **-p <PORT #>** - connects SSH service that's not listening on the default port of 22. Specifiy the port #

`scp`:
- similar to `cp` but works with remote hosts
- can copy local to remote
- **-r** - copy whole directory

`rsync`:
- uses SSH to synchronize files between a remote directory and a local one
- only differences are considered


### Do you already know? Questions

1. A physical screen you are looking at and working from is a **console**.

2. The environment where users can enter commands and the working environment is a **terminal**.

3. A **shell** is needed to interpret the commands which are typed. It offers a command line to type the commands.

4. Six (6) virtual consoles are associated with /dev/tty1 - /dev/tty6. This is what the concoles are named.

5. Create a pseudo terminal device through logging in via SSH or from the graphical interface by opening the terminal.

6. Changing network configuration doesn't require a server reboot because you can directly restart the network service. A server reboot is necessary after making changes to the kernel and kernel modules in use.

7. To have remote access to Linux servers from a windows environment, you can install the PuTTY program.

8. Public key fingerprints of hosts (SSH servers) you've previously connected to are in *~/.ssh/known_hosts*.

9. **ForwardX11** yes option in */etc/ssh/ssh_config* enables support for graphical applications through SSH.

10. `ssh-copy-id` copies public key to the remote server. 


### Review Questions

1. A **console** is the physical screen you're looking at and working on.

2. **ctrl + alt + F2** switches from a text based login/non-graphical to a graphical interface.

3. `w` or `who` shows all users that have a terminal screen open to a linux server.com

4. */dev/pts/0* is the device name used by the first SSH session opened to the server.

5. `ssh -v` gets detailed info on what ssh is doing when logging in. (verbose).

6. `ssh -X` enables support for grahical apps, with security restriction as it's meant to connect to untruster remote servers. `ssh -Y` does the same thing but it bypasses the security restrictions, so it's meant to work with only trusted remote servers. 

7. *~/.ssh/config* is the config file needed to be edited to modify SSH client settings.

8. `sftp lisa@server2` then `put /etc/hosts /tmp` OR `scp /etc/hosts lisa@server2:/tmp` copies the /etc/hosts file to the directory /tmp on server2 with the username lisa.

9. For remote users who want to log in using key-based auth, the public keys are stored in *~/.ssh/authorized_keys*.

10. **ssh-keygen** generates a pair of public/private keys.