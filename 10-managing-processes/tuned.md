# Using tuned
## Exercise 10-4
How to use tuned.

### Step 1: Ensure *tuned* is installed

```bash
sudo dnf -y install tuned
```

### Step 2: Check the status of *tuned*

```bash
systemctl status tuned
```

If it's not active, turn it on.

```bash
systemctl enable --now tuned
```

### Step 4: Explore profiles

Check which profile is currently used.

```bash
tuned-adm active
# Output: 

# Current active profile: virtual-guest
```

Check which profile is recommended.

```bash
tuned-adm recommended
# Output: 

# virtual-guest
```

Activate the *throughput-performance* profile

```bash
tuned-adm profile throughput-performance
# Output: 

# Current active profile: throughput-performance
```

Change it back to the *virtual-guest* profile, since that was the recommended profile.

---