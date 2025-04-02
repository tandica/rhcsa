# Study notes for various tasks

<br>

## To configure local repo and mount it
1. Create the directory you want to point it on `mkdir /mount-point`
2. Create the repo files for AppStream and BaseOS in */etc/yum.repos.d*
3. Edit it in this format and save:

```vim
[title]
name=reponame
baseurl=file:///mount-point
enabled=1
gpgcheck=0
```
4. Test mount with `mount /dev/source /mount-point`
5. Add the mount persistently in */etc/fstab*
  - note the file system, if you need to mount an ISO, use filesystem **iso9660**
  - **if you're not sure of the file system, you can use `blkid` and it will show you it under "TYPE"**
  - for ISO, it can only be mounted as "ro" (read-only), this needs to be specified instead of putting `defaults`
  - if the question asks you to "automatically mount", you can put "auto" in the `defaults section as well
    - `ro,auto`
6. Check for errors in the mount: `mount -a`
7. Verify the files are in the mount-point: `ls -l /mount-point`. `reboot` to verify persistence.

<br>

## To set pw properties for new users
Edit the */etc/.login.defs* file for system-wide configuration.

To verify the changes, create a new user, then run `chage -l username`.

(If you need to set pw properties for existing users, you can use `chage`)

<br>

## To create a container that runs an http server and mount it

1. Install `container-tools` package for podman
2. Create the host directory
3. Get the required httpd image
  - `podman images`
  - If not, `podman search httpd` for the required image
  - `podman pull` the image. Pull a RHEL based one if possible, even like CentOS
4. Run the container with the necessary parameters
  - `podman run`
  - for bind-mounting, ALWAYS use :Z at the end of the repo defn for SELinux labelling
    - /hostdir:/containerdir
5. Add the port and http service to the firewall and reload it 
6. Test changes with `curl`

<br>

## Make a container start as a system user service on boot

1. Enable linger on the current user


