#!/bin/sh
if id $1 &>/dev/null; then
    # Delete the user
   sudo  userdel -r $1
    echo "User '$username' deleted."
else
    echo "User '$username' not found."
fi

