# Journald

## Beanologi

How to make the systemd journal persistent:

1. Create directory for storing the logs: `mkdir /var/log/journald`
2. Edit the */etc/systemd/journald.conf* with vim and include the line `Storage=persistent`.
3. Restart the Systemd journal: `systemctl restart systemd-journald`
4. Flush the journal to ensure changes are applied: `journalctl --flush`

<br >

## CSG

Logs are stored in */var/log* directory.

`systemd-analyze` gives you performance info about the system's boot process.

View logs since a certain time: `journalctl --since=21:30`

`journalctl -p err` looks for error logs.

0

<br >

## DexTutor

n/a
