#!/bin/bash
#
# This script uses user input as an argument

# The if statement checks if an argument was entered when the script was executed
# if not, it asks for input from the user
if [ -z $1 ]; then
	echo enter a name
	read NAME
else
	NAME=$1
fi

echo you have entered the text $NAME 
exit 0
