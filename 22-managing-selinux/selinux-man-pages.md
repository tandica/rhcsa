# Installing SELinux-specific man pages
## Exercise 22-3


### Step 1: Access SELinux man pages.

Check how many man pages are available for SELinux. There will be about 2.

```bash
su - root 

man -k _selinux
```

Search for SELinux packages, look for selinux-policy-docs and install it.

```bash
dnf search selinux

dnf install -y selinux-policy-docs.
```

Set it back to *enforcing* mode and check that it is set properly.

```bash
setenforce 1

getenforce 
# Output:

# Enforcing
```

Check how many man pages are available for SELinux again. You'll see many more listed than last time you ran this command.

```bash
man -k _selinux
```


### Step 2: Explore specific SELinux man pages.

Read through the SELinux settings for the httpd service.

```bash
man -k _selinux | grep http
# Output:

# apache_selinux (8)   - Security Enhanced Linux Policy for the httpd processes
# httpd_helper_selinux (8) - Security Enhanced Linux Policy for the httpd_helpe...
# httpd_passwd_selinux (8) - Security Enhanced Linux Policy for the httpd_passw...
# httpd_php_selinux (8) - Security Enhanced Linux Policy for the httpd_php proc...
# httpd_rotatelogs_selinux (8) - Security Enhanced Linux Policy for the httpd_r...
# httpd_selinux (8)    - Security Enhanced Linux Policy for the httpd processes
# httpd_suexec_selinux (8) - Security Enhanced Linux Policy for the httpd_suexe...
# httpd_sys_script_selinux (8) - Security Enhanced Linux Policy for the httpd_s...
# httpd_unconfined_script_selinux (8) - Security Enhanced Linux Policy for the ...
# httpd_user_script_selinux (8) - Security Enhanced Linux Policy for the httpd_...
```

Go through any specific setting with the following command, based on the output:

```bash
man 8 httpd_selinux
```


---