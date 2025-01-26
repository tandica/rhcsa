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

1. The `head` command shows the first 10 lines in a text file.

2. The `wc` command shows the number of lines, words and characters in a file.

3. To go to the last line in the `less` pager, use **G**.

4. In `cut -d : -f 1 /etc/passwd`, **-d** is used to specify the field delimiter that needs to be used to distinguish different fields with the `cut` command.

5. `ps aux | sort -k3` sorts the third column of the `ps aux` output. If not key is declared, sort happens based on fields.

6. `grep ^anna /etc/passwd` shows lines in /etc/passwd that start with "anna".

7. In regex, **?** makes the previous charcter optional. Ex: *colou?r* searches for both "colour" and "color".

8. In regex, **+** is used to check if the preceeding character occurs at least once. 

9. `awk -F : '/user/{print $4}' /etc/passwd` prints the fourth field of a line in /etc/passwd, if *user* is in that line. **-F** specifies which field operator should be used.

10. `grep -v` shows lines that *do not* contain the regex specified. 


### Review Questions

1. `ps aux | less` shows the output of `ps aux` in a way that's easily browsable.

2. `tail -n5 ~/samplefile` shows the last 5 lines of samplefile.

3. `wc -w ~/samplefile` counts the wouds in samplefile.

4. **ctrl + c** stops showing output.

5. `grep -v -e '^#' -e '^;' file.txt` excludes all lines that begin with **#** or **;**. You have to use **-e** before each definition if you have multiple characters.

6. In regex, you can use **+** to match 1 or more of the preceeding characters.

7. `grep -i text file.txt` allows you to search for "text" in both uppercase and lowercase.

8. `grep -B 5 '^PATH' file.txt` shows all lines starting with "PATH" along with the preceeding 5 lines, as specified. 

9. sed -n 9p m~/samplefile` shows line 9 from samplefile.

10. `sed -i 's/user/users/g' ~/samplefile` replaces "user" with "users" in samplefile. 