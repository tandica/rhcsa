# Isolating targets
## Exercise 17-1


### Step 1: List all targets that allow isolation.

Start from a root user and go to */usr/lib/systemd/system*. earch for the targets that alloow isolation.

```bash
su - root 

cd /usr/lib/systemd/system

grep Isolate *.target
# Output: 

# ctrl-alt-del.target:AllowIsolate=yes
# default.target:AllowIsolate=yes
# emergency.target:AllowIsolate=yes
```


### Step 2: Switch your system to use *rescue.target*.

```bash
systemctl isolate rescue.target
```

You can enter the root password, then switch back to the default mode with `systemctl isolate rescue.target` or reboot with `reboot`. 


### Step 3: Reboot the system with the target file

```bash
systemctl isolate reboot.target
```

---