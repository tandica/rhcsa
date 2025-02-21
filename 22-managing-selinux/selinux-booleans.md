# Working with SELinux booleans
## Exercise 22-6


### Step 1: Explore SELinux booleans in the ftp service.

Search for booleans in your system in the **ftp** service.

```bash
getsebool -a | grep ftp
# Output

# ftpd_anon_write --> off
# ftpd_connect_all_unreserved --> off
# ftpd_connect_db --> off
# ftpd_full_access --> off
# ftpd_use_cifs --> off
# ftpd_use_fusefs --> off
# ftpd_use_nfs --> off
# ftpd_use_passive_mode --> off
# httpd_can_connect_ftp --> off
# httpd_enable_ftp_server --> off
# tftp_anon_write --> off
# tftp_home_dir --> off
```

Change the value of `ftpd_anon_write` to on and verify it.

```bash
setsebool ftpd_anon_write on

getsebool ftpd_anon_write
# Output:

# ftpd_anon_write --> on
```

Use the following command to show the persistency of the boolean settings we just applied. This command shows more details about the boolean than `getsebool -a | grep ftp`.

```bash
semanage boolean -l | grep ftpd_anon
# Output:

# ftpd_anon_write                (on   ,  off)  Determine whether ftpd can modify public files used for public file transfer services. Directories/Files must be labeled public_content_rw_t.
```

You can see the second "off" which means that the boolean is not persistent and the permanent setting is still set to off.

Change the permanent setting to "on". 

```bash
setsebool -P ftpd_anon_write on
```

Check that  the permanent boolean is set to "on".

```bash
semanage boolean -l | grep ftpd_anon
# Output:

# ftpd_anon_write                (on   ,   on)  Determine whether ftpd can modify public files used for public file transfer services. Directories/Files must be labeled public_content_rw_t.
```


---