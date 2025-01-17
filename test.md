# Chapter 2 - Essential Tools

`>` is used for redirecting output to a file. 
Ex: `node server.js > logs.txt` logs the output of the node command in logs.txt. 

`>>` is used for redirecting output to the end of a file, appending it to the bottom of already existing data. 

`2>` and `2>>` works the same way, but for only errors. 

`&>` and `&>>` works the same way, but for **both** output and error messages. 

**Heredocs** - allows multi line input for scripts. Must end with the same keyword. 
Ex: cat > story.txt <<WORD 
        Line 1...
        Line 2...
WORD>>

`echo` - quick text output or file manipulation
       - displays text passed in as an argument 
       - can add and append text to a file 

`file` - displays file type regardless of file extension


`tail` - outputs the last 10 lines of a file
       - can use `-n` option to specify # of lines

`head` - outputs the first 10 lines of a file 

**vim** - text editor
        - has 3 modes:
            - normal
            - editing - use "i" to insert it "a" to append. 
            - Ex - quitting mode. Enter it with esc + :wq to save and exit, :q to quit without saving, or :w to save without exiting. 

`mkdir -p` - creates a parent and child directory if the parent doesn't exist 

**File globbing** - using wildcard characters to to match file names or directory names 
- `*` matches all characters 
       - Ex: `ls *.txt` lists all files in the directory that have the .txt extension 
- `?` matches only 1 character
       - Ex: `ls file?.txt` lists file1.txt and file2.txt but not file10.txt since `?` only matches a single character. 
- `[]` matches 1 character from a set of characters in braces 
       - Ex: `ls file[1-7].txt` lists file1.txt to file7.txt 
- `{}` create a list of options to match 
       - Ex: `ls file{1,2,7}.txt` lists file1.txt, file2.txt and file7.txt 

`less` - view contents one screen at a time with backward movement. Used to page through longer files. 

`wc` - count number of lines, words and characters in a text file or input stream 

`stat` - prints details about files and file systems 

### File permissions 

File permissions include read, write and execute. 

Read = 4

Write = 2 

Execute = 1 

Permissions are split into 3 groups:
- user/owner 
- group 
- others 

On a file, permissions will look like this: 
`-rw-rw-r--`. 

It is split based on which type of user has access to what. 

`-`: The beginning indicates what it is. `-` means it's a file. `-d` means it's a directory. 

`-rw-`: The first 3 characters are permissions for the user/owner of the file and directory. Bere, the user/owner has permissions to read and write but not execute. 

`rw-`

`r--`



