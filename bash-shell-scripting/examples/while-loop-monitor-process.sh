#!/bin/bash
#
# Monitor a process using a while loop

# ps aux lists all running processes on the system
# grep $1 finds lines that contain the argument passed when the script is ran
# grep -v grep excludes lines containing the word grep, otherwise the grep $1 command will match the process running within the script
# everything is redirected to ~/output.txt file
while ps aux | grep $1 | grep -v grep > ~/output.txt
do 
  # allows the script to pause for 5 seconds 
	sleep 5
done

echo your process has stopped, logger $1 is no longer present

exit 0
