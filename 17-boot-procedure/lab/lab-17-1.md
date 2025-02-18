
# Lab 17.1

Lab on targets.

#### 1. Set the default target to **multi-user.target**.

Check the current default target.

```bash
systemctl get-default 
# Output:

# graphical.target
```

Set the default target to what is specified in the instructions.

```bash
systemctl set-default multi-user.target
# Output:

# Removed "/etc/systemd/system/default.target".
# Created symlink /etc/systemd/system/default.target → /usr/lib/systemd/system/multi-user.target.
```

Verify the new default target.

```bash
systemctl get-default 
# Output:

# multi-user.target
```


#### 2. Reboot and ensure the changes were applied.

```bash
reboot
```

![lab 17.1 after reboot](../../img/lab-17-1.png)

Set it back to the graphical console.


---