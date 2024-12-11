#!/bin/bash

if [ $1 == "one" ]; then
  touch /tmp/one
elif [ $2 == "two" ]; then
  echo "Message:" | mail -s "two" root
else 
  echo "Invalid arguments."
fi

exit 0
