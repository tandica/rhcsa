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

**MaxAuthTries** logs failed login attempts

