# SSH

## Beanologi

To access `ssh` from a non-standard port, you can specify the -p option in the ssh command like `ssh -p 2222 tandi@server1.com`

You can create a file */.ssh/config* to store aliases for servers and their non-standard ports if necessary. The permissions on this file must be 600.

*Ex:*
``` bash
Host server1
  Hostname appserver1.net
  User admin
  Port 2222
```

### Public/Private keys

`ssh-keygen` generates public/private key pair.

`ssh-keygen -A` generates mising host keys for the SSH server.

If you get errors with the above command after trying to log in to the erver, you can remove the entries from the known hosts file in */.ssh/known_hosts*.

Public key is in */.ssh/id_rsa.pub*.

Private key is in */.ssh/id_rsa*.

`ssh-copy-id user@servername` copies public key to the remote server. 

To allow root login for SSH, you can edit the */etc/ssh/sshd_config* and add the line `PermitRootLogin yes`.

When you change Port 22 to make another port the default port, do it in this file */etc/ssh/sshd_config* .
- You also need to allow the new port to be accepted by the firewall persistently
  - `firewall-cmd --permanent --add-port 2222/tcp`
  - Then reload the firewall to apply the changes: `firewall-cmd --reload`
  - **You must update the security labels for this to work properly:**
    - `semanage -a -t ssh_port_t -p tcp 2222`
  - You need to restart the sshd service with `systemctl restart sshd`
  - After these steps, you can try logging in with the newly specified port like this: `ssh -p 2222 server1`

<br >

## CSG

You can use the tee command with ssh to capture the SSH command output while still allowing it to flow to the destination.

*Ex:*
`ssh tandi@server.example.com 'ls -l' | tee output.log`

In the above example, you can capture the output of the `ls -l` command and save it to your local system in a file named *output.log*.

The *~/.ssh/authorized_keys* file holds the public keys for remote users who want to login using key based authentication.

When you run ssh-keygen, it creates the public and private key, but it doesn't create the authorized_keys file. 

You can manually do it like this on the remote server: 

```bash
mkdir -p ~/.ssh               
touch ~/.ssh/authorized_keys      
chmod 700 ~/.ssh                   
chmod 600 ~/.ssh/authorized_keys
```

OR, you can do it with this one-step command:

```bash
shh-copy-id user@server1
```

<br >

## DexTutor

You may have to install ssh like `dnf -y install openssh-server openssh-client`.

The service will need to be started and firewalld will have to be configured to allow the SSH traffic. 

- `systemctl enable --now sshd` enables the sshd service at boot and starts it 
- `firewall-cmd --permanent -add-service=ssh`
- `firewall-cmd --reload`

For testing this locally, you can install 2 VMs, then use SSH to connect to the other. 
