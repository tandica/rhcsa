# Lab 22

Lab on managing SELinux.

#### 1. Change the Apache document root to /web1. In this directory, create a file with the name index.html and give it the content 'welcome to my web server'. Restart the httpd process and try to access the web server. This will not work. Fix the problem.

**1.1. Create a new directory called /web1 with an index file that contains the specified message.**

```bash
mkdir /web1

vim /web1/index.html
```

**1.2. Change the DocumentRoot in the main Apache config file.**

```bash
su - root 

vim /etc/httpd/conf/httpd.conf
```

Add the following lines: 

```bash
DocumentRoot "/web1"

<Directory "/web">
 AllowOverride None
 Require all granted
</Directory>
```

**1.3. Restart the httpd process and try to access the web page.**

```bash
systemctl restart httpd

curl http://localhost
# Output:

#   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
# <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
# 	<head>
# 		<title>Test Page for the HTTP Server on Red Hat Enterprise Linux</title>
```

It outputs the default Red Hat web page because SELinux is not configured properly on the **/web1** director.

**1.4. Restart the httpd process and try to access the web page.**

```bash
semanage fcontext -a -t httpd_sys_content_t "/web1(/.*)?"
```

Apply the labels. This step must always be done afterwards when changing `fcontext` or the targeted files and drectories will retain their old labels.

```bash
restorecon -R -v /web1
# Output:

# Relabeled /web1/index.html from unconfined_u:object_r:default_t:s0 to unconfined_u:object_r:httpd_sys_content_t:s0
```

**1.5. Test the changes.**

Type the same *cURL* command to see if the labels were applied correctly.

```bash
curl http://localhost
# Output:

# Welcome to my web server!
```

Now we can see the output of the `index.html` file we created in **/web1**.

#### 2. In the home directory of the user root, create a file with the name hosts1 and give it the specified content. Move the file to the /etc directory and do what is necessary to give this file the correct context.

**1.1. Create the file and add the content**

```bash
vim hosts1
```

Add the following:

`
192.168.4.200 labipa.example.com
192.168.4.210 server1.example.com
192.168.4.220 server2.example.com
`

**1.2. Move the file to the /etc directory and apply the correct SELinux labels**

Move the file and confirm it's in the correct directory.

```bash
mv hosts1 /etc

ls /etc | grep hosts
# Output:

# hosts
# hosts1
```

Check the labels on the /etc/hosts file and compare with the labels on /etc/hosts1

```bash
ls -Z /etc/hosts
# Output:

# unconfined_u:object_r:net_conf_t:s0 /etc/hosts

ls -Z /etc/hosts1
# Output:

# unconfined_u:object_r:admin_home_t:s0 /etc/hosts1
```

We need to change the context type to the same as the /etc/hosts file.

```bash
semanage fcontext -a -t net_conf_t /etc/hosts1

restorecon -R -v /etc/hosts1
# Output:

# Relabeled /etc/hosts1 from unconfined_u:object_r:admin_home_t:s0 to unconfined_u:object_r:net_conf_t:s0
```

Check that changes were applied.

```bash
ls -Z /etc/hosts1
# Output:

# unconfined_u:object_r:net_conf_t:s0 /etc/hosts1
```


---
