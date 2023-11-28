#!/bin/bash


    if [ $# != 2 ]; then
        echo "Usage: create_user <username>"
        echo "Argument should be exactly 2"
    else
        echo "Creating user with name $1..."
        sudo useradd -m -p$(openssl passwd -1 $2) $1

        if [ $? -eq 0 ]; then
            echo "Successfully created user: $1"
        else
            echo "Failed to create user: $1"
        fi
    fi

