# Chapter 2 - Essential Tools

`>` is used for redirecting output to a file. 
Ex: `node server.js > logs.txt` logs the output of the node command in logs.txt. 

`>>` is used for redirecting output to the end of a file, appending it to the bottom of already existing data. 

`2>` and `2>>` work the same way, but for only errors. 

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
            - editing - use "I" to insert it "a" to append. 







