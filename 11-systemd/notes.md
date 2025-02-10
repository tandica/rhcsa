# Chapter 11: Working with Systemd


### Do you already know? Questions

1. To show all service unit files on the system which are currently loaded, use `systemctl -t service`.

2. Systemd "wants" are system specific and managed through */etc/systemd/system*.

3. To avoid conflicts between incompatible units, you should mask it. This makes it impossible to enable.

4. Active (Running), Active (Exited), and Active (Waiting) are all valid statuses for Systemd.

5. Socket units monitor socket activity, which includes a file being accessed or network port being accessed. They do not monitor PATH activity, that is done by path unit types. 

6. Service, mount and socket are valid Systemd unit types.

7. To find out which Systemd units have dependencies to a specific unit, use `systemctl list-dependencies --reverse`.

8. To change the default editor of Systemd to vim, do this: SYSTEMD_EDITOR=/bin/vim.

9. To define a Systemd dependency that ensures the boot precedure doesn't fail if the dependency fails, use the keyword **Wants**. It defines a unit is "wanted" without setting a hard requirement.

10. When working with units in systemctl, it's always the last word of the command. *Ex:* `systemctl start unit`.