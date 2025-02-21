#!/bin/bash
#
# This script monitors user login

until users | grep $1 > /dev/null
do
	echo $1 is not logged in yet
	sleep 5
done
echo $1 has just logged in

exit 0
