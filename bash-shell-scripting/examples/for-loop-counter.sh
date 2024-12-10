#!/bin/bash
#
# This script is a simple counter that counts down to 2.

for (( COUNTER=100; COUNTER>1; COUNTER-- )); do
	echo $COUNTER
done
exit 0
