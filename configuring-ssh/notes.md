# Chapter 20: Configuring SSH

**ssh**
- helps establish remote connections to servers
- needs to be secure
- dictionary attacks are common against SSH servers 
    - attacker uses common passwords to try and log in repeatedly 
- SSH is usually hosted on port 22

**To protect SSH servers:**
1. Disable root login
2. Disable password login
3. Configure a non default port for SSH to listen on
4. Allow only specific users to log in via SSH 

To protect against port scans, configure SSH to listen on another port. 

To avoid being locked out of your server when changing the SSH port, open 2 sessions to the SSH server. 
- One session applies changes and tests, and the other keeps the current connection open
- the active session won't be disconnected

After chsnging the SSH port, you need to reconfigure SELinux for this change 

`semanage port` changed label on the target port

`semanage port -l` checks if the port has a label. 

`semanage port -a` adds a label to a port. 

`semanage port -m` modify the current port assignment. 

**AllowUsers** option in ssh_config file. 
- allows only specified users, even root user can't access it if they're not explicitly stated
- safer than just denying login for root 
- you can still act as root as an allowed user, just use su -  

Options in sshd config

**MaxAuthTries** logs failed login attempts

**Max Sessions** specifies the number of sessions that can be open from one IP address

**TCPKeepAlive** is used to monitor whether the client is available or not. Specifies whether or not to clean up inactive TCP sessions. 

**Port** defines TCP listening port. 

**PermitRootLogin** indicates whether to allow or disable root login 

**MaxAuthTries** specifies max # of authentication tries. After reaching half of this #, it logs failures to syslog. 

**AllowUsers**: space separated list of users who are allowed to connect to the server. 

**PasswordAuthentication** specifies whether to allow pw authentication or not. It’s on by default, turn off to use only public/private keys. 

**ClientAliveInterval** specifies the interval, in seconds, that packets are sent to. Prevents timeout from inactivity, sets the timeout. 

**ClientAliveCountMax** specifies the # of client alive packets that need to be sent without needing a response. 

**UseDNS*: if on, it uses DNS name lookup to match incoming IP address to names. 

**ServerAliveInterval** specifies the interval, in seconds, at which a client sends a packet to a server to keep the connection alive. 

**ServerAliveCountMax** specifies the max # of packets a client sends to a server to keep connections alive. 

<br />

**Passphrase**: in public/private keys, using a passphrase makes the key pair stronger. 

To cache a passphrase: 
1. `ssh-agent /bin/bash` to start the agent for the current bash shell. 
2. `ssh-add` to add the passphrase for the current user's provate key. 

<br />

### Do you already know? Questions

1. To prevent brute force attacks against SSH servers, you can have SSH listen to a different port (not port 22), disable password login and allow specific users only to login. 

2. **AllowUsers** parameter limits SSH server access to certain users. 

3. To provide a non-default port (2022) with the correct SELinux label, use `semanage port -a -t ssh_port_t -p tcp 2022`. 

4. **MaxAuthTries** starts logging failed login attempts after reaching half the number specified in this parameter. 

5. To get info about failed SSH login attempts, analyze the log file */var/log/secure*. 

6. **UseDNS** can be responsible for connection time issues related to login because SSH is trying to do a reverse lookup of the DNS name belonging to a target IP address. If a faulty DNS config is used, it will take time. 

7. **UseDNS** doesn't have anything to do with keeping SSH connections alive. That would be **TCPKeepAlive**. 

8. SSH client settings should be set in *~/.ssh/config*. These can only be applied for individual users. 

9. To configure a session that already has public/private key pairs to enter passphrase only once, do `ssh-agent /bin/bash` then `ssh-add`. 

10. By default, an SSH server can only support *10 sessions* open at the same time with MaxSessions. 


### Review Questions

1. To cache the passphrase set on the private key, use `ssh-agent /bin/bash` then `ssh-add`. 

2. To allow only user lisa to log in to the SSH server, edit */etc/ssh/sshd_config* and add `AllowUsers lisa`. 

3. To configure an SSH server to listen on 2 ports, use 2 Port lines in the */etc/ssh/sshd_config* file, one being port 22. 

4. The main SSH config file is */etc/ssh/sshd_config* (server side). 

5. When you cache the passphrase for your key, it's stored in a protected area in memory. 

6. The SSH client settings for all users are located in */etc/ssh/ssh_config*. CHECK THIS. 

7. Use the parameter **MaxSessions** to change the max # of concurrent settings. By default, it's set to 10. 

8. Use `semanage -a -t ssh_port_t -p tcp 2022` to configure SELinux to allow SSH to bind to port 2022. 

9. Use `firewall-cmd --add-port=2022/tcp --permanent` then `firewall-cmd --reload` to configure the firewall on the SSH server to allow incoming connections to port 2022. 

10. If you experience long timeouts while trying to establish an SSH connection, try **UseDNS**. It gets the name of the target host for verification purposes and is on by default. 

