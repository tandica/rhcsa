# Discovering `journalctl`
## Exercise 13-2

### 1. Explore journalctl

The below command automatically uses the `less` pager and you can use `less` commands to go through the file.

```bash
journalctl
# Type q to quit
```

This command specifies all the contents of the journal without using a pager.

```bash
journalctl --no-pager
# Type q to quit
```

### 2. Using journalctl options 

This command shows real-time messages from the journal:

```bash
journalctl -f
```

For filter option, type `journalctl` with a space and press tab. 
For example: 
```bash
journalctl_UID=1001
```

The **_UID** filter was listed in the filter output and it returns messages that have been logged for the account with that UID.

This command shows the last 20 lines of the journal (similar to tail -n 20):

```bash
journalctl -n 20
```

This command shows errors only:

```bash
journalctl -p err
```

For getting messages from a specififc time range, you can use `--since` and `--until` options. The time parameter is in the format **YYYY-MM-DD hh:mm:ss**. You can also use **yesterday**, **today** and **tomorrow** as parameters.

Example:

```bash
journalctl --since yesterday
```

This command shows you as much detail as possible, including different options used for each log entry:

```bash
journalctl --o verbose 
```

Look for a details of a service: 

```bash
journalctl_SYSTEMD_UNIT=sshd.service 
```

### 3. Combining journalctl options

You can combine various options to get detailed output of the info you want.

For instance, the below command shows all errors that have been written since yesterday.

```bash
journalctl --since yesterday -p err
```

---