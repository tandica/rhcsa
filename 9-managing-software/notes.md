# Chapter 9: Managing Software

**dnf** is useed to manage software packages. Designed to work with repositories.

Repository: online software packages.

`dnf config-manager --add-repo=http://url.com/repo` generates repo client file

`dnf config manager --add-repo=file:///repo/BaseOS` use the local path if you copied contents of the RHEL installation disk to /repo. Since it's located on the disk, you don't need a URL. Just reference the local path.

** **When using `dnf config-manager`, you must edit the repo file */etc/yum.conf.d* to include the "gpgcheck=0 line".**

*/etc/pki* directory store the subscription and entitlement sertifications for Red Hat products and registered accounts.

You need to be able to tell the server what repo to use.

Packages are often signed with a GPG key for security purposes, especially online repos. It makes it possible to chrck if the package was altered since the repo owner provided them. If the repo is hacked, the GPG key won't match and the `dnf` command will complain. 

`dnf repolist` verifies availability of repos 

`dnf search` searches packages based on a given string in package name or summary. It searches online then downloads the latest findings metadata. Then, it looks for in package name/summary for given string. 

`dnf search all` does the same as above except a more thorough search cuz it searches in description as well. 

`dnf provides` and `dnf whatprovides` looks for packages of a specific filename. *Ex:* `dnf provides */Containerfile`. 

`dnf info` gets info about a peckage before you install it. *Ex:* `dnf info nmap`.

`dnf list` shows list of packages available. Use with the package name to show version and if there are new versions. *Ex:* `dnf list kernel`. 

`dnf list installed` shows packages installed in the server already. 

**Package group** refers to a collection of related software packages bundled together to fulfill a common purpose. It makes it easy to install packages commonly used together. 

`dnf group list` lists all group packages. 

`dnf group install` installs all packages from a group. 

`dnf history` shows the history of the use of `dnf` command. Each command that has run has an id. You can undo things based on that id. *Ex:* `dnf history undo 2`. 

**Profile** is a list of packages installed together for a particular use case. You can select the profile you want to use. 

**Module**: a set of rpm packages that belong together and adds features to package management. It's organized around specific versions of an OS and can have one or more application streams. 

**Stream** allows for different versions of packages to be offered through the same repos. It contains one specific version and uodates are provided for a specific stream. 

`rpm` is the old command for downloading packages. It’s not recommended now, but can still be used for getting info about packages. You can querY RPM db or package files. 

`rpm -qf`uses file name as an argument to find the specific RPM package a file belongs to. 

`rpm -ql` uses RPM db to provide a list of all files in an RPM package. 

`rpm -qi` uses RPM db provide package info. Same as yum.info. 

`rpm -qd` uses RPM db to show all documentation available in the package 

`rpm qc` uses RPM db to show all config file that are available in the package. 

`rpm -q --scripts` uses RPM db to show scripts used in the package. More useful if used with **-qp**. 

`rpm -qp` queries previously listed options using RPM package file. Tells you what's in thenpackage before you install. 

`rpm -qR` shows dependencies for a specific package 

`rpm -V` shows which parts of a specific package have been changed since installation

`rpm -Va` verifies all installed packages and shows which parts of a package have changed since installation. Good for package integrity check. 

`rpm -qa` lists all packages installed on the server. 

**Mount** 
- similar to plugging a USB drive into the computer 
- makes content accessible to the system 
- connecting a storage drive to a specific folder in your file system
- imagine your file system as a big office building 
    - storage devices like CDROM is a separate room with files 
    - "Mounting" is creating a door that connects that room to the office building 


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


### Review Questions

1. `createrepo` command allows you to transform a directory into a repository once it has a collection of RPM packages. 

2. To point a repo to a link, you need the **[label] name** and **baseurl**. 

3. `dnf repolist` confirms if a repo is available. 

4. `dnf provides */useradd` allows you to search the RPM package with the file "useradd". 

5. `dnf group list` shows the name of dnf groups. `dnf group info "Security Tools"` shows the content of a group. 

6. `dnf module enable php:5.1` allows for a certain version of PHP psckage to be installed without actually installing it. 

7. `rpm -q --scripts packagename` allows you to check if an installed package contains dangerous scripts. `rpm -qp --scripts packagename.rpm` allows you to chrck if a package which is *not yet installed* has dangerous scripts. 

8. `rpm -qd packagename` shows documentation in an RPM package. 

9. `rpm -qf /pathtofile` shows which RPM package a file comes from. 

10. `. repoquery` queries software from a repo. 

