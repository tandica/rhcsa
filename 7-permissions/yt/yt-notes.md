# Permissions

## beanologi

Add a user: `useradd username`.

Set a passwork for a user: `passwd username`, then press enter and type in the pw you want to set in the prompt.

`chage --list username` allows you to see the password properties of a certain user.

`chage ` has an interactive interface that can be accessed by typeing `chage username`.

You can also just use the options instead of the interactive mode: 

`chage username --mindays 1 --maxdays 3 --lastday 2025-04-16 --warndays 14 --inactive 5 --expiredate 2025-05-16`

To get a date that is a certain number of days (64) after the current day, you can use `date -d + 64days`.

**Set system-wide password expiry defaults:** edit the */etc/login.defs* file and change the `PASS_...` parameters. This change will be applied to new users created.

<br>

## CSG 

Change pw for current user: `passwd`.

Set a user account to expire: `chage -E 2025-05-05 username`. User won't be able to log in after that date. Good to use for temporary accounts. 

Make an account never expire: `chage -E -1 username`. You can use this **-1** option for other options too, like **-M**. 

`info chage` gives info onthe command and its options. `chage -h` does the same, except more summarized.

<br>

## DexTutor

n/a
