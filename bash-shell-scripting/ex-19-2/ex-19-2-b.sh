#!/bin/bash
#
# This script outputs arguments in a flexible way when it is run.

echo you have entered $# arguments

for i in $@
do
	echo $i
done 

exit 0
