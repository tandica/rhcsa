# Chapter 9: Managing Software

**dnf** is useed to manage software packages. Designed to work with repositories.

Repository: online software packages.

`dnf config-manager --add-repo=http://url.com/repo` generates repo client file

`dnf config manager --add-repo=file:///repo/BaseOS` use the local path if you copied contents of the RHEL installation disk to /repo. Since it's located on the disk, you don't need a URL. Just reference the local path.



### Do you already know? Questions

1. "gpgcheck" is not mandatory in a .repo file.

2. If a server is not registered with RedHat, no installation source is used. You must connect to a repo before you install something.

3. In the .repo file, refer to a repository that is in the directory /repo on the local file system with **baseurl=file:///repo**. If it's on the local file system, it uses the URI file:// + the path of the local file, which is why there are 3 slashes. 

4. GPG packet signing is recommended on internet repos but not required on local repos that are for internal use only. 

5. To search the package that contains the file semanage, use either `dnf provides seinfo` OR `dnf whatprovides */seinfo`.

6. The dnf module component **application stream** allows you to work with different versions side by side. 

7. To install a specific profile from a dnf module application stream, add the profile name using a /. For instance, `dnf module install php:8.1/devel` installs devel profile of the php application stream.

8. `dnf install` installs RPM files while looking for package dependencies in the current repos. It's better thsan using `rpm` cmd since that one doesn't consider dnf repos.

9. `rpm -qf` find which RPM package a specific file belongs to.

10. `rpm -qp --scripts packagename.rpm` tells you if there are scripts in an RPM package you downloaded. **-p** queries the package file.
