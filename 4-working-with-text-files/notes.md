# Chapter 4: Working with text files Notes 

`awk`: manipulate, display and analyze data in text files
    - syntax: `awk 'pattern {action}' file` where pattern is regex or condition and action is what you want to do like print, modify, etc. 
    - *Ex:* `awk -F: '/user/{print$4}' /etc/passwd 
`prints the fourth field of of a line specified in the directory 

`sed` - performs text modifications in files and pipelines
    - replace text globally or first occurence in each line, delete lines, print specific lines 
    - *Ex:* `sed -i 's/oldtext/newtext/g' file.txt

`cut` - filter specific columns or characters from a text file

`sort` - sort contents of a file

`wc` - counts # of lines, words and characters ina text file 

`less` - opens text file in a pager which allows for easy reading
    - **q**: quits
    - **/text**: forward search 
    - **?text**: backward search 
    - **n**: repeats the last search

`more` - go through file contents page by page
    - has similar features to less
    - move utility is ended when the file end is reached unless you use -p option

`tac` - displays contents of file in reverse of cat so first lines are at the bottom 

`tail -f var/log/messages` - shows real time messages written to thwe log file 
    - **-f** refreshes display as new lines are added to the file

**grep options**

- -i: matches upper and lower case letters
- -v: shows lines that **do not** contain the character
- -r: searches files in current directory and all subdirectories
- -e: search for files matching more than one regex

### Do you already know? Questions

1. 