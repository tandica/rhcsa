# Hard and Soft Links

**Hard links**
- "mirror" of a file
- hardlinks of the same file share permissions, timestamps and ownership
- cannot link directories
- has the actual contents of the original file, so you can view it if the file is moved or deleted
- has the same inode number and permissions of original file

`ln myfile myhardlink` creates a hardlink to myfile.


**Soft/Symbolic Links**
- link that points to a path of another file
- similar to a shortcut
- can span across different file systems and directories
- can point to an absolute or relative path
  - if you move relative links into another directory, they won't work anymore, but an absolute link would
- if you change the permissions of a soft link, you'll change permissions of the target file
- allows directories to be linked
- only has the path of the original file, not the contents
- has a new inode number 

`ln -s myfile mysoftlink` creates a soft link to myfile. 
