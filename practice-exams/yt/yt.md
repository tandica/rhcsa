# All Review YT Vids

2 vms in the exam - one server will have network configs and other won't. 

in the other one you need to set hostname, ip, dns, gateway, pw. you need to reset the root paw on the one with nw config. 

go through the the questions for 10-15 mins to understand everything you need to do 

there are tasks to be performed on both servers. 

seat number/workstation replaces x variable 

you can choose to use the base machine and ssh into the servers or you can use the servers directly. 

### 1. configure tcp/ip as follows 

use nmtui - does it only work as root user? 

edit the existing connection and add the config 

activate the connection 

set the hostname in nmtui 

`route -n` lists the gateway to ensure its correct 

### 2. configure servera vm repo is available for these packages 

baseos and appstream 

- create a repo file example.repo

[base] 
name=base
baseurl=http://ex/BaseOs
gpgcheck=0

[app] 
name=base
baseurl=http://ex/AppStream
gpgcheck=0

check if things are running 
yum repolist

### 3. selinux httpd issues on port 82

https service is having issues. check the status of it 

systemctl status httpd 

try restarting 

systemctl restart httpd

check the port context of port 80, which is a known port of httpd: semanage port -l | grep 80 

there's no port 82 in that list of the http_port_t 

add the correct context to port 82: semanage port -a -t http_port_t tcp -p 82

restart httpd service and enable it to be safe 

to test it, you can do curl server.url.com:82 and see if any output is there 

### 4. groups, users and group memberships 

add a secondary group for a new user : useradd -G sysadm harry

make user have no access to interactive shell: `useradd jon -s /sbin/nologin`

give a group access to add users in the server: edit the config file with visudo. it goes directly to the config file. put `%sysadmin ALL=/usr/bin/useradd`. The % is needed to define the group. find the path of useradd with `which useradd`. 


to give a user the ability to set passwords, without asking for the sudo pw, do this with visudo: `bob ALL=(ALL) NOPASSWD: /usr/bin/passwd`

To give a user full access: `sally ALL=ALL`

To give a user access to all cmds without sudo password: `sadi ALL=(ALL) NOPASSWD: ALL`


### 5. create collaborative directory 

make directory owned by a certain group: `chgrp marketing /shared/marketing`

change directory permissions to only be accessed by members of the group and no access for others: `chmod 2770 /shared/marketing`

### 6. make a cronjob 

### 7. nfs

### 9. Give user specific permissions to a file/directory

Give user ella read/write permissions to the /var/tmp/fstab file:

```bash 
setfacl u:ella:rw- /var/tmp/fstab
```

Make user sadi have no read/write/execute permissions on the same file:

```bash 
setfacl u:sadi:--- /var/tmp/fstab
```


### 10. configure time synchronization with an available server 

install chronyd service 

edit chrony.conf file 
- comment out the pool name with iburst at the end 
- put in the server name and keep iburst at the end 
- save 

you can add ntp to the firewall services 

restart and enable chronyd service 

### 11. find files created by a certain user and copy them into a directory 

find / -user eddi -exec cp -r {} /some-dir \;










































