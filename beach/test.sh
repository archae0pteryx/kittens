#!/bin/bash
grep -q "$user" /etc/passwd
if [ $? -eq 0 ]; then
   echo "user Exists"
else
   echo " Name not Found"
fi
