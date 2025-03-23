# cyber custodian yt vid 

2 vms in the exam - one server will have network configs and other won't. 

in the other one you need to set hostname, ip, dns, gateway, pw. you need to reset the root paw on the one with nw config. 

go through the the questions for 10-15 mins to understand everything you need to do 

there are tasks to be performed on both servers. 

seat number/workstation replaces x variable 

you can choose to use the base machine and ssh into the servers or you can use the servers directly. 

1. configure tcp/ip as follows 

use nmtui - does it only work as root user? 

edit the existing connection and add the config 

activate the connection 

set the hostname in nmtui 

`route -n` lists the gateway to ensure its correct 

2. configure servera vm repo is available for these packages 

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

3. selinux httpd issues on port 82

https service is having issues. check the status of it 

systemctl status httpd 

try restarting 

systemctl restart httpd

check the port context of port 80, which is a known port of httpd: semanage port -l | grep 80 

there's no port 82 in that list of the http_port_t 

add the correct context to port 82: semanage port -a -t http_port_t tcp -p 82

restart httpd service and enable it to be safe 

to test it, you can do curl server.url.com:82 and see if any output is there 

4. groups, users and group memberships 

add a secondary group for a user : useradd -G sysadm harry

make user have no access to interactive shell: useradd -s /sbin/nologin

give a group access to add users in the server: edit the config file with visudo 



















































