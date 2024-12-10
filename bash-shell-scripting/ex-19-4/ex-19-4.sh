#!/bin/bash
#
# This script checks if an argument is a file, directory, or neither.
# Run it with an argument.

if [ -f $1 ]
then
	echo "$1 is a file"
elif [ -d $1 ]
then
	echo "$1 is a directory"
else
	echo "I don't know what $1 is"
fi

exit 0
