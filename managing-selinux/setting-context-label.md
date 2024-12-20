# Setting a context label on a Nondefault Apache DocumentRoot
## Exercise 22-2


### Step 1: Create a simple apache server.

Ensure Apache is installed.

```bash
su - root 

dnf install -y httpd curl
```

Create a directory to host the server.

```bash
mkdir /web
```

Create an index.html file with some text.

```bash
vim /web/index.html
```

Configure the Apache config file to point to the **/web** directory you created. To do this, make the value of `DocumentRoot` to be `/web`.

You also need to add the following to ensure that Apache doesn't block access to the new DocumentRoot setting.

```html 
<Directory "/web">
 AllowOverride None
 Require all granted
</Directory>
```

```bash
vim /etc/httpd/conf/httpd.conf 
```

Save and exit.

Restart and enable the httpd service.

```bash
systemctl enable --now httpd
```


### Step 2: Test the servers' SELinux settings and apply the context label.

Call localhost using the cURL command. Notice that the output is the default RedHat main page.

```bash
curl http://localhost
```

To get the contents of the index.html you created, go into permissive mode, then try the same command again.

```bash
setenforce 0

curl http://localhost
# Output:

# Welcome to the server! :) 
```

Apply the context label. This command tells SELinux to allow the Apache web server to read everything in the **/web** directory and its subdirectories. 

```bash
semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
```

Apply your changes to the necessary files and directories, in this case everything in **/web**.

```bash
restorecon -R -v /web
```

> After running the `semanage` command, you need to run the `restorecon` command to actually apply the security label changes. The `restorecon` command ensures that the correct security labels are applied. 

Set the SELinux mode back to *enforcing* and try running the cURL command. 

```bash
setenforce 1

curl http://localhost
# Output:

# Welcome to the server! :) 
```

Now it works without having to be in *permissive* mode because the security labels are set correctly.


---